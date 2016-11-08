#!/usr/bin/env ruby
# encoding: utf-8

($LOAD_PATH << File.expand_path("..", __FILE__)).uniq!

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

require "bundle/bundler/setup"
require "alfred"

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback
  
  FileUtils.rm_rf('/tmp/up-next')
  directory_name = "/tmp/up-next"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)

	fb.add_item({
		:uid      => "Delete Artwork Folder",
		:title    => "Delete Artwork Folder",
		:subtitle => "Delete Artwork Folder",
		:arg      => "Delete Artwork Folder"
	})
  puts fb.to_alfred
end



