# This gem module creates a pagelogger that can used to log the visit to each
# web page in a Ruby based web application (e.g., Ramaze, Rails). Each web page is
# logged in Common Log Format to support analysis by an external Web Log Analyzer
#
# Author::    Al Kivi <al.kivi@vizitrax.com>
# License::   MIT

require 'logger'

module Vizi
# This class includes a set of methods that extend the Ruby Logger
  class PageLogger < ::Logger

    attr_accessor :ip
    
# This method will add the remote ip address to the Logger class 
    def initialize (*args)
      super
      ip = ''
    end
    
# This method will add the ip address to the logger class
    def addremote(ipaddr)
      self.ip = ipaddr
    end
    
# This method will create the log entry adding the request information
# Calling format is ... log.page '/admin/login.htm' or similar
    def page(*args)
      request = args.first
      self.info([self.ip, request])
    end  
    
  end # Pagelogger
  
# This class customizes the Logger::Formatter to match the Common Log Format
  class LogFormatter < Logger::Formatter
    # Provide a call() method that returns the formatted message.
    def call(severity, time, program_name, message)
      if severity == "INFO"
        message.insert(1, ' -')
        message.insert(2, ' - ')
        message.insert(3, "["+Time.now.strftime("%d/%b/%Y:%H:%M:%S %z")+"] ")
        request = message[4]
        message[4] = '"'+request+'"'
        message.insert(5, ' 200')
        message.insert(7, ' 0')
        print_message = "#{String(message)}\n"
      else
        super
      end
    end
  end
  
end # Vizi
