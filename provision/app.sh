# Support npm install -g
# http://stackoverflow.com/questions/19352976/npm-modules-wont-install-globally-without-sudo
npm config set prefix '~/.npm-packages'

line='export PATH="$PATH:$HOME/.npm-packages/bin"'
grep -q "$line" /home/vagrant/.bashrc || echo "$line" >> /home/vagrant/.bashrc

# Install node packages.
cd /vagrant
npm install -g node-gyp
npm install -g babel webpack
npm install

# For some reason node-sass always shows this error until it is re-installed:
#   Error: `libsass` bindings not found in /vagrant/ux/node_modules/node-sass/vendor/linux-ia32-14/binding.node. Try reinstalling `node-sass`?
# cd /vagrant/ux
# npm install node-sass

# Specify no docs for gems
line='gem: --no-ri --no-rdoc'
touch ~/.gemrc
grep -q "$line" ~/.gemrc || echo "$line" >> ~/.gemrc

# Install gems
cd /vagrant/webapp
bundle install
rake db:migrate db:test:prepare
# The webapp/db/seeds.rb file should be written
# in a way that it can be safely executed multiple times
rake db:seed
