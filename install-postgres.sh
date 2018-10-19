#!/bin/bash

echo "Installing postgresql"
sudo apt-get install libpq-dev
sudo apt-get install -y postgresql-clientll
sudo apt-get install -y postgresql

sudo -u postgres createuser --interactive
