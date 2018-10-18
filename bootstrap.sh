#/bin/bash

usage() { echo "The usage is -u <username> -p <password> -r <RUBY_VERSION>"; }

while getopts 'u:p:r:' opt; do
	case "${opt}" in
		u) UNAME=${OPTARG};;
		p) PWORD=${OPTARG};;
		r) RUBY_VERSION=${OPTARG};;
		*) usage;;
	esac
done

if [ -z "$UNAME" ] || [ -z "$PWORD" ] || [ -z "$RUBY_VERSION" ]; then
	usage
	exit 1
fi

echo "Creating user $UNAME"
sudo adduser  $UNAME --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "$UNAME:$PWORD" | sudo chpasswd

echo "Add $UNAME to sudoers"
usermod -aG sudo $UNAME

echo "Switch to $UNAME account"

# su - $UNAME

sudo apt-get update

echo "Begin Rails install"
echo "Installing unzip..."
sudo apt-get install -y unzip

echo "Installing git..."
sudo apt install -y git-all

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

echo "Installing postgresql"
sudo apt install -y postgresql-clientll
sudo apt install -y postgresql
