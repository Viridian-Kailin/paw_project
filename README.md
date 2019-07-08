# README
Local copy of the PAW project staff website. Primary website can be found here: https://fierce-falls-99896.herokuapp.com/

# Prerequisites:
* Ruby 2.6.1
* Postgres 11.2
* Rails 5.2.3
* Git BASH or GUI

## Where to download prereqs:
* Install Ruby on Rails with Git and Ruby included: http://railsinstaller.org/en
* Install Postgres: https://www.postgresql.org/download
  * Be sure that you've set yourself as the superuser for Postgres before proceeding.

# Installing:
* Ensure all prereqs are installed and functional *before* following these steps
* Fork the PAW project repro: https://github.com/ADavisDon/paw_project/fork
* Clone the forked repository: `git clone https://github.com/<your-username>/paw_project.git`
* `cd` into the folder location
* Run `bundle install`

# Database initialization
To create the database, run the following commands in the command prompt/tutorial:
* `rails db:create`
* `rails db:setup`
* `rake db:sampledata`
  * If you'd like to start off with a bare bones database, then run `rake db:initial` instead.

# Basic navigation
At this time, the project is setup only to acknowledge two usernames: *admin* and *staff*. Any additional users created will not have access to the rest of the project. The two default logins, *admin* and *staff* should have been created with `rails db:setup` and their passwords should be their respective username. If not, go into the command prompt/terminal and run the following commands:
* `rails c`
* `User.create(username: 'admin', password: 'admin')`
* `User.create(username: 'staff', password: 'staff')`

*Login permissions will be addressed at a later time.*

# How to run the test suite
To run the test suite, run the following command in your command prompt/terminal window:
* `bundle exec rspec`