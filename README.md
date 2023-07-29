# README


**Ruby version: ruby "3.2.2"**
To install ruby "3.2.2" Follow steps below:
### Steps for package manager
## rbenv
1. Update your package list
  `sudo apt update`
2. Install dependencies
  `sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev`
3. Install rbenv
  `curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash`
  `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc`
  `echo 'eval "$(rbenv init -)"' >> ~/.bashrc`
  `source ~/.bashrc`
4. Install Ruby 3.2.2
  `rbenv install 3.2.2`
5. Set it as your default Ruby version
  `rbenv local 3.2.2`
6. Verify the installation
  `ruby -v`
## RVM
1. First, update your package list
  `sudo apt update`
2. Install dependencies
  `sudo apt install curl g++ gcc autoconf automake bison libc6-dev libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev libreadline-dev libssl-dev`
3. Install RVM
   `curl -sSL https://get.rvm.io | bash -s stable`
   `source ~/.rvm/scripts/rvm`
4. Install Ruby 3.2.2
  `rvm install ruby-3.2.2`
5. Set it as your default Ruby version
  `rvm use 3.2.2 --default`
6. Verify the installation
  `ruby -v`

**Clone repository**
1. hoose the way you want to clone it
### HTTPS
`git clone https://github.com/pawelmaryon/Job-Interview-Pokemon.git`

### SSH key
 `git clone git@github.com:pawelmaryon/Job-Interview-Pokemon.git`

2. Install bunndler
  `gem install bundler`

3. Install all the gem dependencies for the Rails application
  `bundle install`

**System dependencies**:
  - ### MySQL (MariaDB)  

**Database initialization**
## Linux
*To download and install MariaDB on linux go to https://mariadb.org/download/?t=repo-config&d=20.04+%22focal%22&v=10.5&r_m=xtom_ams
Choose a distribution
and follow the steps that will appear below*.
To start server on Linux:
 - `sudo service mariadb start`
 or
 - `sudo systemctl start mariadb`
## Mac
### To install MariaDB on Mac you can use Homebrew package manager
1. install homebrew if you dont have it already installed
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. next install MariaDB
`brew install mariadb`
3. start MariaDB server
`mysql.server start`
4. To get information about the installed MariaDB package
`brew info mariadb`

* Database creation
  - `rails db:create`
  - `rails db:migrate`

* How to run the test suite:
 - `bundle exec rspec`

* Services
 - ### Service fetching Pokemons
 `app/services/pokemon_service.rb` 

**API Dokumentation**
1. rswag gem installed - [rswag](https://github.com/rswag/rswag)
2. To check API documentation run `rails server` and got to `localhost:3000/api-docs`
