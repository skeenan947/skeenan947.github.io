#!/bin/bash
if [ -f $HOME/.rvm/scripts/rvm ] && type rvm|grep -q "is a function"
then
  echo "RVM is already installed!"
else
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles stable --autolibs=read-fail
fi
source /var/jenkins_home/.rvm/scripts/rvm
if rvm list rubies|grep -q 2.2.5
then
  echo "ruby 2.2.5 is already installed"
else
  rvm install 2.2.5
  gem install bundler
fi
