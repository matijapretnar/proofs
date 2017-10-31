import os
import re

def file_contents(file):
    with open(file) as f:
        return f.read()


def extract_identifiers(sig_contents):
    identifiers = []
    for match in re.finditer('kind +(?P<idents>.*?) +type', sig_contents):
        for ident in re.split(', *', match.group('idents')):
            identifiers.append(ident)
    for match in re.finditer('type +(?P<ident>.*?) +', sig_contents):
        identifiers.append(match.group('ident'))
    return identifiers


def prepend_identifiers(identifiers, prefix, contents):
    replacement = {re.escape(ident): prefix + '/' + ident for ident in identifiers}
    # We replace the identifiers from the longest to the shortest, so that
    # substrings aren't replaced too early, resulting in of/xxx/value instead
    # of xxx/of/value.
    patterns = sorted(replacement.keys(), key=len, reverse=True)
    pattern = re.compile(r'\b(' + '|'.join(patterns) + r')\b')
    return pattern.sub(lambda m: replacement[re.escape(m.group(0))], contents)


def remove_sig_declaration(contents):
    return re.sub('^sig .+\.\n', '', contents)


def remove_mod_declaration(contents):
    return re.sub('^module .+\.\n', '', contents)


def flatten_sig(sig_file):
    contents = file_contents(sig_file)
    match = re.search('accum_sig +(?P<accum_sig>.+)\.', contents)
    if match:
        accum_sig = os.path.join(
            os.path.split(sig_file)[0],
            match.group('accum_sig') + '.sig'
        )
        accum_contents = remove_sig_declaration(flatten_sig(accum_sig))
        contents = re.sub('accum_sig +(?P<accum_sig>.+)\.', accum_contents, contents)
    return contents


def flatten_mod(mod_file):
    contents = file_contents(mod_file)
    match = re.search('accumulate +(?P<accum_mod>.+)\.', contents)
    if match:
        accum_mod = os.path.join(
            os.path.split(mod_file)[0],
            match.group('accum_mod') + '.mod'
        )
        accum_contents = remove_mod_declaration(flatten_mod(accum_mod))
        contents = re.sub('accumulate +(?P<accum_mod>.+)\.', accum_contents, contents)
    return contents

os.makedirs('../translations_scaffold', exist_ok=True)
with open('../translations_scaffold/syntax.sig', 'w') as sig_file, open('../translations_scaffold/syntax.mod', 'w') as mod_file:
    sig_file.write('sig syntax.\n')
    mod_file.write('module syntax.\n')
    mam_identifiers = extract_identifiers(flatten_sig('../safety/mam.sig'))
    sig_file.write(prepend_identifiers(mam_identifiers, 'mam', remove_sig_declaration(flatten_sig('../safety/mam.sig'))))
    mod_file.write(prepend_identifiers(mam_identifiers, 'mam', remove_mod_declaration(flatten_mod('../safety/mam.mod'))))
    mod_identifiers = extract_identifiers(flatten_sig('../safety/mon.sig'))
    sig_file.write(prepend_identifiers(mod_identifiers, 'mon', remove_sig_declaration(flatten_sig('../safety/mon.sig'))))
    mod_file.write(prepend_identifiers(mod_identifiers, 'mon', remove_mod_declaration(flatten_mod('../safety/mon.mod'))))
    del_identifiers = extract_identifiers(flatten_sig('../safety/del.sig'))
    sig_file.write(prepend_identifiers(del_identifiers, 'del', remove_sig_declaration(flatten_sig('../safety/del.sig'))))
    mod_file.write(prepend_identifiers(del_identifiers, 'del', remove_mod_declaration(flatten_mod('../safety/del.mod'))))
    eff_identifiers = extract_identifiers(flatten_sig('../safety/eff.sig'))
    sig_file.write(prepend_identifiers(eff_identifiers, 'eff', remove_sig_declaration(flatten_sig('../safety/eff.sig'))))
    mod_file.write(prepend_identifiers(eff_identifiers, 'eff', remove_mod_declaration(flatten_mod('../safety/eff.mod'))))

extensions = {'mon', 'del', 'eff'}
for xxx in extensions:
    for yyy in extensions - {xxx}:
        for template in ['xxx2yyy.mod', 'xxx2yyy.sig', 'xxx2yyy.thm']:
            with open(template) as in_file:
                source = in_file.read()
            with open(os.path.join('../translations_scaffold', template.replace('xxx', xxx).replace('yyy', yyy)), 'w') as out_file:
                out_file.write(source.replace('xxx', xxx).replace('yyy', yyy))