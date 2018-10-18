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
su -c ./install-rails.sh -m "$UNAME" 
su -c ./install-postgres.sh -m "$UNAME"
