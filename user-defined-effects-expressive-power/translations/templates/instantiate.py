xxx = input('Source:')
yyy = input('Target:')
for template in ['xxx2yyy.mod', 'xxx2yyy.sig', 'xxx2yyy.thm']:
    with open(template) as in_file:
        source = in_file.read()
    with open(template.replace('xxx', xxx).replace('yyy', yyy), 'w') as out_file:
        out_file.write(source.replace('xxx', xxx).replace('yyy', yyy))
