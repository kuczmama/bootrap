#!/bin/bash

RUBY_VERSION=$1;

echo "Installing unzip..."
sudo apt-get install -y unzip

echo "Installing git..."
sudo apt install -y git-all
sudo apt-get install -y  build-essential

# INSTALL RAILS
echo "Installing rbenv.."
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
reset
echo "Finished installing rbenv"

#!/bin/bash
rbenv -v
echo "Installing ruby.."
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
echo "Finished installing ruby"
ruby -v

echo "Installing rails.."
gem install bundler
gem install rails
rbenv rehash
echo "Finished installing rails"
rails -v
rbenv rehash