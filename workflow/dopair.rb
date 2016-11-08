require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "./bundle/bundler/setup"
require "alfred"
require './lib/dacpclient'
require 'socket'

if ARGV[0].count == 4
  pin = ARGV[0].split("")
  client = DACPClient::Client.new "Alfred", 'localhost', 3689
  client.pair pin
  puts "Pairing Successful!"
end