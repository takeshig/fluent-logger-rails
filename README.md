# Fluent Logger Rails

Rails logger implement with [Fluentd](http://fluentd.org/) to collecting your App logs from different servers.

## README

*Note: Not tested in production*

### Introduction

This is a basic gem that provides a FluentLoggerRails::Logger
which can be swapped instead of the default Rails 3 logger.

### Usage

In order to swap the Rails default logger, we require the railtie included
in the gem so that it is loaded during Rails initialization process.

```ruby
gem 'fluent-logger-rails', :require => 'fluent_logger_rails/railtie'
```

You will also need to specify the following on a ~config/fluent_logger.yml~
to connect to the fluentd process. You can also include erb tags to specify settings during runtime.

```yaml
development:
  fluent_host: '127.0.0.1'
  fluent_port: 24224
  appname:     'rails3_test'
```

Otherwise, you can set up the following environment variables when starting the rails server.
By default, the port used by fluentd is 24224.

```bash
APPLICATION_NAME='appname' rails server thin
```

On the fluentd side, you will need to setup the proper configuration so that it matches
the tag of your application. Example:

```conf
<match appname.**>
   type stdout
</match>
```

### Features

By including this gem, all of the calls to ~logger~ will be rendered as a JSON message
and sent to the fluentd process.

```ruby
class MessagesController < ApplicationController
  def index
    logger.info   "Something happened"
    render :text => "nothing"
  end
end
```

...will send the following to fluentd

```bash
rails3_test.stdout: { "text":"  Processing by MessagesController#index as HTML",  "level":"INFO" }
```

## Todo list

* TODO Fix problem during development when starting server and empty log/#{Rails.env}.log file does not exists
* TODO Log out the error stack traces
* TODO Add supported Rails versions
* TODO Add tests for Rails 3.1, Rails 3.2
