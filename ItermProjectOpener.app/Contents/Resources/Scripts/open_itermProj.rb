#!/usr/bin/env ruby
require 'rubygems'
require 'appscript'
require 'yaml' 
include Appscript

exit unless !ARGV.first.nil? and File.exists?(ARGV.first) 

ITERM = app("iTerm")
ITERM.activate
TERMS = ITERM.count(:each => :terminal)
TERMINAL = ITERM.terminals[TERMS]

YAML.parse_file(ARGV.first).transform.each do |tab|
  tab = {
    :session => 'Default',
    :cmd => '',
    :name => 'Defualt'
  }.merge!(tab)
  
  TERMINAL.launch_(:session => tab[:session])
  TERMINAL.sessions[-1].write(:text => tab[:cmd])
  TERMINAL.sessions[-1].name.set(tab[:name])
end