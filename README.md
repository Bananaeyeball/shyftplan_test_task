# Shyftplan test task

##### Rails api that serves companies and employees.
Includes getting records, updating, destroying and creating new ones

## Ruby version
```sh
ruby-2.7.0
```

## Rails version
```sh
Rails 6.1.3.2
```

## System dependencies
```sh
  gem 'pg'
  gem 'fast_jsonapi'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop'
  gem 'pry-rails'
```
## Installation
```sh
bundle install
rails db:create
rails db:migrate
```

## How to run the test suite
```sh
rspec .
rubocop .
```
