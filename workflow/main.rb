#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "./bundle/bundler/setup"
require "alfred"
require 'dacpclient'
require "dmapparser"
require 'socket'

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback
  
  directory_name = "/tmp/up-next"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)
  
  client = DACPClient::Client.new "Alfred", 'localhost', 3689
  client.login

  db = client.default_db
  query = ARGV.join(" ")
  
  results = client.search(query, nil, db)
  
  results.mlcl.to_a.each_with_index do |song, i|
	#artwork isn't working right, i'll just wait for the ability to use remote images as the icon and pass in the URL directly
  	art = nil
    id = song.miid
    icon = {:type => "default", :name => "artwork.png"}

    file = File.file?("/tmp/up-next/alfred-up-next-#{id}.png")
  	if file
    	file = File.open("/tmp/up-next/alfred-up-next-#{id}.png", "r")
    	icon[:name] = file.path
    else 
      if i < 10
      	begin
      	  art = client.artwork(db.item_id, song.miid, 40, 40)
        rescue DACPClient::DACPForbiddenError=>e
      	end
      	
      	if art != nil
      	  file = File.open("/tmp/up-next/alfred-up-next-#{id}.png", "w")
      	  file.puts(art)
      	  icon[:name] = file.path
      	end
      end
    end
	
  	fb.add_item({
  		:uid      => "#{song.minm} - #{song.asar}",
  		:title    => "#{song.minm} - #{song.asar}",
  		:subtitle => "#{song.asal}",
  		:icon     => icon,
  		:arg      => "#{song.miid} #{song.asar} - #{song.minm}"
  	})
  end
  puts fb.to_alfred
end



