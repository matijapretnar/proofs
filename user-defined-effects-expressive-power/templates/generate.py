import os

LANGUAGES = {'mam', 'del', 'eff', 'mon'}
TARGET_DIR = '../proofs/'
GENERATED_PREFIX = 'auto-'


def substitute(string, subs):
    for old, new in subs.items():
        string = string.replace(old, new)
    return string


def generate(source_name, subs):
    with open(source_name) as source_file:
        source_contents = source_file.read()
    target_contents = substitute(source_contents, subs)
    target_name = os.path.join(TARGET_DIR, substitute(source_name, subs))
    if GENERATED_PREFIX not in source_name and os.path.exists(target_name):
        print('File {} already exists. Skipping.'.format(target_name))
    else:
        with open(target_name, 'w') as target_file:
            target_file.write(target_contents)


for language in LANGUAGES:
    subs = {'xxx': language}
    generate('auto-xxx.sig', subs)
    generate('auto-xxx.mod', subs)
    generate('xxx.sig', subs)
    generate('xxx.mod', subs)
for source in LANGUAGES - {'mam'}:
    for target in LANGUAGES - {'mam', source}:
        subs = {'xxx': source, 'yyy': target}
        generate('auto-xxx2yyy.sig', subs)
        generate('auto-xxx2yyy.mod', subs)
        generate('xxx2yyy.sig', subs)
        generate('xxx2yyy.mod', subs)
