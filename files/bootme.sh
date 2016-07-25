#!/usr/bin/env bash
#
# This script installs puppet 3.x or 4.x and deploy the manifest using puppet apply -e "include role_db"
#
# Usage:
# Ubuntu / Debian: wget https://raw.githubusercontent.com/relybv/dirict-role_db/master/files/bootme.sh; bash bootme.sh
#
# Red Hat / CentOS: curl https://raw.githubusercontent.com/relybv/dirict-role_db/master/files/bootme.sh -o bootme.sh; bash bootme.sh
# Options: add 3 as parameter to install 3.x release

# default major version, comment to install puppet 3.x
PUPPETMAJORVERSION=4

### Code start ###
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if [ "$#" -gt 0 ]; then
   if [ "$1" = 3 ]; then
     PUPPETMAJOR=3
   else
     PUPPETMAJOR=4
  fi
else
  PUPPETMAJOR=$PUPPETMAJORVERSION
fi

if [ "$PUPPETMAJOR" = 3 ]; then
    MODULEDIR="/etc/puppet/modules/"
  else
    MODULEDIR="/etc/puppetlabs/code/modules/"
fi

# install dependencies
if which apt-get > /dev/null 2>&1; then
    apt-get -q update
  else
    echo "Using yum"
fi

apt-get install git bundler zlib1g-dev libaugeas-ruby -y -q || yum install -y git bundler zlib-devel libaugeas-ruby

# get or update repo
if [ -d /root/role_db ]; then
  echo "Update repo"
  cd /root/role_db
  git pull
else
  echo "Cloning repo"
  git clone https://github.com/relybv/dirict-role_db.git /root/role_db
  cd /root/role_db
fi

# install puppet if not installed
if which puppet > /dev/null 2>&1; then
    echo "Puppet is already installed."
  else
    bash /root/role_db/files/bootstrap.sh $PUPPETMAJOR
fi

# prepare bundle
echo "Installing gems"
gem install rake puppetlabs_spec_helper puppet --no-rdoc --no-ri -q 
# bundle install --path vendor/bundle --without development system_tests
# install dependencies from .fixtures
echo "Preparing modules"
/usr/local/bin/rake spec_prep
#bundle exec rake spec_prep
# copy to puppet module location
cp -a /root/role_db/spec/fixtures/modules/* $MODULEDIR
echo "Run puppet apply"
/usr/local/bin/puppet apply -e "include role_db"
