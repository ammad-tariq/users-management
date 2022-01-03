# Users Management

This is a Users Management application.

## Development Setup

1. Clone the repo:

  ```
  $ git clone git@github.com/ammad-tariq/users-management.git
  $ cd users-management
  ```

2. Install dependencies and prepare database:

  ```
  $ ./bin/setup
  ```

3. You're up and running. Just start rails server:

  ```
  $ bundle exec bin/rails s
  ```

4. (Optional) For front-end development, webpack-dev-server on a seperate terminal will enable live-reload:

  ```
  $ bin/webpack-dev-server
  ```

Notes:

* If you encounter errors, you may need to run `bundle install`, `rails db:migrate` or `yarn install`.
* Make sure you have PostgreSQL up and running. You can use `ps auxwww | grep postgres` to check if Postgres is running.

## Running tests

UserManagement is covered with basic functional tests using RSpec and FactoryBot.

To run the test suite in the `users-management` directory run:
  ```
  Prepare Test Database:
  $ rails db:test:prepare

  Ruby tests for controllers, models via factories, RAILS_ENV is especially required inside VSCode Remote Dev Environment:
  $ RAILS_ENV=test rspec spec

  ```
