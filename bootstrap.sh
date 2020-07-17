#!/usr/bin/env bash
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

# Prevents "Warning: apt-key output should not be parsed (stdout is not a terminal)".
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo -E apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

echo updating package information
apt-get -y update >/dev/null 2>&1

install Ruby ruby-full
install 'development tools' build-essential autoconf libtool

# echo installing current RubyGems
gem update --system -N >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Git git
install SQLite sqlite3 libsqlite3-dev

install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser vagrant

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev zlib1g-dev
install 'Blade dependencies' libncurses5-dev
install 'ExecJS runtime' nodejs
install 'Yarn' yarn

install 'Heroku' heroku

echo "test -d /vagrant/projects && cd /vagrant/projects" >> /home/vagrant/.bashrc

echo 'all set, rock on!'
