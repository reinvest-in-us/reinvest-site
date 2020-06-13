# README

## Development

### Getting started
To run this application locally, you'll need:

* Ruby 2.6.6 (can be installed with [`ruby-install`](https://github.com/postmodern/ruby-install))
* Bundler (`gem install bundler` after above ruby version is installed)
* Postgresql (`brew install postgresql`)
* A recent version of Chromedriver (`brew cask install chromedriver` or `brew cask upgrade chromedriver`)


### Common commands

**Starting the server**

```
rails s
```

**Database commands**

Creating database (first time)
```
rails db:create
```

Running migrations (periodically)
```
rails db:migrate
```

Updating test schema (after running development migrations)
```
rails db:test:prepare
```

Seeding the development database with data from `db/seeds.rb`
```
rails db:seed
```

**Running tests**

```
rspec spec
```

**Creating new users**

New users can be created by running the following rake task, which will prompt you for a password for that user.

Currently users are able to log in and add or edit all district and meeting information. 
```
# bash
rake users:create[admin@example.com]

# zsh
rake "users:create[admin@example.com]"
```

## CI and Deploys

**CI**

Github actions currently runs tests against every pushed commit. See [.github/workflows](.github/workflows) for the configuration.

**Deploying**

Heroku auto-deploys from `master` when tests pass.

The site is currently available at [https://defund-police-staging.herokuapp.com](https://defund-police-staging.herokuapp.com/)
