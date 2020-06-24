# Reinvestin.us

## About

A website to provide organizers, activists and engaged residents a simple organizing tool to get everyday citizens to their local City Council and/or other local elected body meetings. https://reinvestin.us

### Contributing

Currently, this application is maintained and developed by a small core team. We are accepting issues for bug reports and feature requests, and pull requests for bug fixes.

If you're interested in getting more involved than what's outlined above, please shoot us an email at dev@reinvestin.us!

## Development

### Getting started
To run this application locally, you'll need:

* Ruby 2.6.5 (can be installed with [`ruby-install`](https://github.com/postmodern/ruby-install))
* Bundler (`gem install bundler` after above ruby version is installed)
* Postgresql (`brew install postgresql`)
* A recent version of Chromedriver (`brew cask install chromedriver` or `brew cask upgrade chromedriver`)
* Run `bin/setup` to prepare dev environment.
* Run `yarn` to install JS dependencies.

**Starting the server**

```
rails s
```

**Watching for JavaScript changes**
```
/bin/webpack-dev-server
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

Currently users are able to log in to '/admin' and add or edit all district and meeting information.
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

When deploying, Heroku will run migrations and `rake one_offs:all`. Any one-time, idempotent data migrations should be included in that task.
