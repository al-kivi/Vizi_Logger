# This is a sample application that uses the Vizi_logger gem classes
# 
# This application will create a log file with a set of simulated web log records
# You will need a web log analyzer (e.g., Analog) to confirm the readability of this file
#
# Author::    Al Kivi <al.kivi@vizitrax.com>

# require '~/appgems/vizi_logger/lib/vizi_logger.rb'  # use this line for testing

require 'rubygems'   # needed for ruby 1.8.7
require 'vizi_logger'

# weblog = Vizi::PageLogger.new(STDOUT)

weblog = Vizi::PageLogger.new('./log/vizidemo.log',shift_age = 'weekly')

weblog.addremote '127.0.0.1'  # for batch testing
# weblog.addremote request.remote_addr  # use this in live mode

weblog.formatter=Vizi::LogFormatter.new

urlist = ["/","/users/login","/users/list","/posts","/posts/view/1"]

25.times do
  sleep rand*2  # create random interval
  page_url = urlist[(5*rand).to_i]  # select a random page url
  weblog.page page_url
end

#weblog.page 
