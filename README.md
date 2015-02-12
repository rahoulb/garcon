# Garcon

Garcon is a simple Service Locator object.  

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

services.register(:file_server) { MyFileServer.new }
services.register(:email_server) { MyEmailServer.new(configuration_details) }
services.register(:hostname) { "mysite.example.com" }
```

Then use this Service Locator to find your related objects, instead of
having hard-coded constants.  

```ruby
class FileStorage < Struct.new(:services)
  def store_file file
    services[:file_server].store file, path: DEFAULT_PATH
  end
  DEFAULT_PATH = '/home/someone/somewhere';
end

file_storage = FileStorage.new(services)
file_storage.store_file my_file
```

If you're writing a Rails app I like to configure it like so - create
your services object in config/initializers/services.rb.  Then store it
in your application's configuration: 

```ruby
services = Garcon::ServiceLocator.new
services.register(:thing_server) { ThingServer.new }
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
