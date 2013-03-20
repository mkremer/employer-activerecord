# Employer::ActiveRecord [![Build Status](https://travis-ci.org/mkremer/employer-activerecord.png)](https://travis-ci.org/mkremer/employer-activerecord)

NOTE: This code is still experimental

ActiveRecord backend for Employer

## Installation

Add this line to your application's Gemfile:

    gem 'employer-activerecord'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install employer-activerecord

## Usage

Generate and run the migration to create the employer\_jobs tablein your
database:

```
rails g employer:active_record
bundle exec rake db:migrate
```

Ensure that your Employer configuration starts with something like the below:

```ruby
require "./config/environment.rb"
require "employer-activerecord"

pipeline_backend Employer::ActiveRecord::Pipeline.new
```

If you're not using Rails then require whatever sets up your application's
environment instead of config/environment.rb before requiring 
employer-activerecord. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
