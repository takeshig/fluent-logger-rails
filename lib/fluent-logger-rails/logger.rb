require 'active_support'
require 'active_support/core_ext'
require 'fluent-logger'

module FluentLoggerRails

  class Logger < ActiveSupport::BufferedLogger

    CONFIGURATION_FILE = "fluent_logger.yml"
    LOG_LEVEL_MAP      = ['DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL', 'LEVEL']

    def initialize(options={}, level=DEBUG)
      @level   = level || DEBUG
      @port    = options[:port]
      @host    = options[:host]
      @appname = options[:appname]
      @debug   = options[:debug]

      @fluent_logger = Fluent::Logger::FluentLogger.new(@appname, { :host => @host, :port => @port })
    end

    def add(severity, message=nil, progname=nil, &block)
      @last_message ||= []
      @last_message << message
      return if message.blank?
      if message.match /^Completed/
        post_to_remote(severity, @last_message.join("\n"))
        @last_message = []
      end
      puts message if @debug
    end

    def flush; end

    def level
      @level
    end

    def level=(l)
      @level = l
    end

    def close
      @fluent_logger.close
    end

    private
    def post_to_remote(severity, message)
      message_level = LOG_LEVEL_MAP[severity] || 'UNKNOWN'
      @fluent_logger.post 'stdout', log = { :text => message, :level => message_level }
    end
  end

end
