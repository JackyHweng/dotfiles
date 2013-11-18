#!/bin/bash

CURRDIR=`pwd`
SCRIPTDIR=$(cd `dirname $0` && pwd)

sudo apt-get-repository ppa:keithw/mosh
sudo apt-get update
sudo apt-get install -y perl curl wget python-software-properties mosh ctags screen ngrep

# Update git submodules
cd $SCRIPTDIR
git pull
git submodule update --init
cd vim-config
git submodule update --init

# Create Links
cd ~
if [[ -f .bashrc ]]; then
  mv .bashrc .bashrc.old
fi
ln -s $SCRIPTDIR/bashrc .bashrc
ln -s $SCRIPTDIR/bashrc.`uname` .bashrc.`uname`
if [[ -f .gitconfig ]]; then
  mv .gitconfig .gitconfig.old
fi
ln -s $SCRIPTDIR/gitconfig .gitconfig
ln -s $SCRIPTDIR/git-global-ignore .git-global-ignore
ln -s $SCRIPTDIR/tigrc .tigrc
ln -s $SCRIPTDIR/vim-config .vim
ln -s $SCRIPTDIR/slate.js .slate.js
ln -s $SCRIPTDIR/zshrc .zshrc
ln -s $SCRIPTDIR/screenrc .screenrc
ln -s .vim/vimrc .vimrc
ln -s .vim/gvimrc .gvimrc
mkdir bin
cd bin
ln -s $SCRIPTDIR/z/z.sh
# Ack
curl http://beyondgrep.com/ack-2.04-single-file > ack
chmod 755 ack

if [[ "$1" == "-ooyala" ]] ; then
  cd ~
  git clone ssh://git@git.corp.ooyala.com/users/jigish dotfiles-ooyala
  ./dotfiles-ooyala/config.sh
fi

cd /tmp
wget https://bitbucket.org/pypa/setuptools/raw/0.7.2/ez_setup.py -O - | sudo python
cd /usr/local
sudo git clone https://github.com/Lokaltog/powerline.git
cd powerline
sudo ./setup.py build
sudo ./setup.py install

cd $CURRDIR

