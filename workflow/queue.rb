#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "./bundle/bundler/setup"
require 'dacpclient'
require 'socket'

client = DACPClient::Client.new "Alfred", 'localhost', 3689
client.login
client.queue ARGV[0]
ARGV.shift
name  = ARGV.join(" ")
puts name