#!/usr/bin/env bash

set -e

FTP_HOST='oplab9.parqtec.unicamp.br'
LOCALPATH=$TRAVIS_BUILD_DIR/restic/output
REMOTEPATH='/ppc64el/restic'
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)

if [ $github_version = $ftp_version ]
then
  cd $LOCALPATH
  git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
  cd repository-scrips/
  chmod +x empacotar-deb.sh
  chmod +x empacotar-rpm.sh
  sudo mv empacotar-deb.sh ..
  sudo mv empacotar-rpm.sh ..
  cd ..
  sudo ./empacotar-deb.sh restic restic-$github_version $github_version " "
  sudo ./empacotar-rpm.sh restic restic-$github_version $github_version " " "restic is a program that does backups right"
  if [ $github_version < $ftp_version ]
  then
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /teste/matheus/ $LOCALPATH/restic-$github_version-ppc64le.deb"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /teste/matheus/ $LOCALPATH/rpmbuild/RPMS/ppc64le/restic-$github_version-1.ppc64le.rpm"
  fi
fi

# Upload files from LOCALPATH recursively to REMOTEPATH
#lftp -f "
#set dns:order "inet"
#set xfer:use-temp-file yes
#set xfer:temp-file-name *.tmp
#open ftp://$FTP_HOST
#user $USER $PASS
#mirror -R --continue --reverse --no-empty-dirs --no-perms -I restic* $LOCALPATH $REMOTEPATH
#bye
#"

