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
gem 'fluent-logger-rails', :git => 'git://github.com/huacnlee/fluent-logger-rails.git'
```

You will also need to specify the following on a 'config/fluent_logger.yml'
to connect to the fluentd process. You can also include erb tags to specify settings during runtime.

```yaml
development:
  fluent_host: '127.0.0.1'
  fluent_port: 24224
  appname:     'rails3_test'
  debug:       true
```

On the fluentd side, you will need to setup the proper configuration so that it matches
the tag of your application. Example:

```conf
<match rails3_test.**>
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

## Performance

```
# run Rails.logger.info("...3481+ chars")
       user     system      total        real
1 times  0.000000   0.000000   0.000000 (  0.000242)
100 times  0.020000   0.000000   0.020000 (  0.023021)
1000 times  0.180000   0.040000   0.220000 (  0.241728)
```

## Todo list

* TODO Fix problem during development when starting server and empty log/#{Rails.env}.log file does not exists
* TODO Log out the error stack traces
* TODO Add supported Rails versions
* TODO Add tests for Rails 3.1, Rails 3.2
