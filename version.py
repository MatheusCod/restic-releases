#!/usr/bin/env python3

import requests
# find and save the current Github release
html = str(
    requests.get('https://github.com/restic/restic/releases/latest')
    .content)
index = html.find('href="/restic/restic/tree/v')
github_version = html[index + 27:index + 32]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/restic/'
    ).content)
index = html.rfind('restic-')
ftp_version = html[index + 7:index + 12]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save de oldest version on the FTP server
index = html.find('restic-')
delete = html[index + 7:index + 12]
file = open('delete.txt', 'w')
file.writelines(delete)
file.close()
