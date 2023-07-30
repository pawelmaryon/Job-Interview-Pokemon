# README


**Ruby version: ruby "3.2.2"**
To install ruby "3.2.2" Follow the steps below:
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
1. Choose the way you want to clone it
### HTTPS
`git clone https://github.com/pawelmaryon/Job-Interview-Pokemon.git`

### SSH key
 `git clone git@github.com:pawelmaryon/Job-Interview-Pokemon.git`

2. Install bundler
  `gem install bundler`

3. Install all the gem dependencies for the Rails application
  `bundle install`

**System dependencies**:
  - ### MySQL (MariaDB)  

**Database initialization**
## Linux
*To download and install MariaDB on linux go to https://mariadb.org/download/?t=repo-config&d=20.04+%22focal%22&v=10.5&r_m=xtom_ams
Choose a distribution and follow the steps that appear*.
To start server on Linux:
 - `sudo service mariadb start`
or
 - `sudo systemctl start mariadb`
## Mac
### To install MariaDB on Mac you can use Homebrew package manager
1. Install Homebrew if you don't have it already installed
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
* Droping database
 - `rails db:drop`

* How to run the test suite:
 - `bundle exec rspec`

* Services created using Rails conventions
 - ### Service for fetching Pokemons
  `app/services/pokemon_service.rb` 
 - ### View Objects for Presentation Logic
moving presentation logic to `app/presenters/pokemon_presenter.rb`, [here](https://www.rubyguides.com/2019/09/rails-patterns-presenter-service/) is a great resource to understand how it works.

**API Documentation**
1. rswag gem installed - [rswag](https://github.com/rswag/rswag).
2. To update Swagger definition run `rake rswag:specs:swaggerize`
3. To check API documentation run `rails server` and got to `localhost:3000/api-docs`, all endpoints are there.
## Consuming API:
There are two endpoints
1. List all pokemons using curl:
 - to get list of all pokemons run in your terminal `curl http://localhost:3000/pokemons`
 - to get specific pokemon run in your terminal `curl http://localhost:3000/pokemons/{id}`
2. List all Pokemon using [Postman](https://www.postman.com/)
 - type in the input field `http://localhost:3000/pokemons` select `GET` request and press `SEND`
 - to get specific pokemon `http://localhost:3000/pokemons{id}` select `GET` request and press `SEND`, where *id* is dynamic 'it can be any number that's on the list of all Pokemons.
