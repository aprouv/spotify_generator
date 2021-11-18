# README

Requirements

ruby 2.7.3
postgresql >= 13

Getting started

To get started with the app, clone the repo and then install the needed gems:

bundle install

Configure database

rails db:create
rails db:migrate
rails db:seed

Seed the database

Run:

rails db:seed

Finally, run the test suite to verify that everything is working correctly:

rails test

If the test suite passes, you'll be ready to run the app in a local server:

rails server
