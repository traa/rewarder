# For the 'apt-add-repository' command
apt-get update
apt-get install -y software-properties-common

# Add Postgres Repository
# http://www.postgresql.org/download/linux/ubuntu/
apt-add-repository 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Add Ruby Repository for Ruby 2.2.3
# https://www.brightbox.com/blog/2015/01/05/ruby-2-2-0-packages-for-ubuntu/
apt-add-repository -y ppa:brightbox/ruby-ng

# Update package list
# Required after adding new apt repositories
apt-get update

# Curl is used to install other things
apt-get install -y curl

# Some NPM modules require g++
apt-get install -y g++

# Bundler requires git
apt-get install -y git

# Node & NPM
curl -sL https://deb.nodesource.com/setup_0.12 | sudo -E bash -
apt-get install -y nodejs

# Ruby
apt-get install -y ruby2.2 ruby2.2-dev
gem install bundler foreman

# Postgres
apt-get install -y libpq-dev
bash /vagrant/provision/postgres.sh

# Imagemagick for webapp paperclip gem
apt-get install -y imagemagick

# Install app: npm modules & ruby gems
su - vagrant -c 'bash /vagrant/provision/app.sh'

# Begin in the /vagrant folder upon login.
line='cd /vagrant'
grep -q "$line" /home/vagrant/.bashrc || echo "$line" >> /home/vagrant/.bashrc

echo "

Provisioning Complete. CTRL+C if this shows for more than a few seconds...

"
