# Garcon

Garcon is a simple Service Locator object.  

Why?

Dependencies, that's why.  

Each object in your application has dependencies and related objects.

For a good design, you need to know those dependencies and keep track of
them.  

For a flexible design it's useful to be able to switch those
dependencies in and out.  

So instead of hard-coding your dependencies or injecting them as a long
trail of constructor parameters, use a service locator;
register your services in the locator and tell it to fetch one for you
when you need it.  

Your dependency map becomes a list of services - :file_server,
:email_server etc.  

Your implementation can be switched out at a moment's notice without
affecting anything else.  

You can go home relaxed and have a nice cup of tea.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'garcon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install garcon

## Usage

Create an instance of your service locator, and then register your
services with it: 

```ruby
services = Garcon::ServiceLocator.new

services.register(:file_server) { MyFileServer.new(services) }
services.register(:path_finder) { MyPathFinder.new(services) }
```

Then use this Service Locator to find your related objects, instead of
having hard-coded constants.  For example, MyFileServer never needs to
know how the Path Finder is implemented; it just needs to respond to #default.

```ruby
class MyFileServer < Struct.new(:services)
  def store file
    write file: file, path: services[:path_finder].default
  end
end

file_storage = FileStorage.new(services)
file_storage.store_file my_file
```

If you're writing a Rails app I like to configure it like so - create
your services object in config/initializers/services.rb.  Then store it
in your application's configuration: 

```ruby
services = Garcon::ServiceLocator.new
services.register(:thing_server) { ThingServer.new(services) }
MyStuff::Application.config.services = services
```

Then, in your application controller, add a protected method to access
it: 

```ruby
class ApplicationController < ActionController::Base

  protected

  def services
    MyStuff::Application.config.services
  end
end
```

And finally you can then use it in your controllers as you wish (and
then pass it on to everything else): 

```ruby
class MyThingsController < ApplicationController
  def index
    @things = services[:thing_server].find_all
  end
end
```


## Contributing

1. Fork it ( https://github.com/rahoulb/garcon/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
