#!/usr/bin/env ruby

require 'httparty'
require './lib/ip_grabber'

response = HTTParty.get('http://icanhazip.com')
puts response.body

ip = IPGrabber.new
puts ip.get
