require 'rubygems'
require 'bundler'

Bundler.require

require './twitter'
run Twitter::API
