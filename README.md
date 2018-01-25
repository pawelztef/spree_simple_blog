

Installation
------------

Add to your Gemfile:

```ruby
gem 'spree_simple_blog', github: 'pawelztef/spree_simple_blog'
```

Bundle your dependencies and run the installation generator:

```shell
    bundle install
    rake railties:install:migrations
    rake db:migrate
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

