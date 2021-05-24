#!/usr/bin/env ruby

require 'httparty'

response = HTTParty.get('http://icanhazip.com')
puts response.body
