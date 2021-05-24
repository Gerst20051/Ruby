#!/usr/bin/env ruby

def hello_world
  puts 'Hello World'
end

def hello(name = 'World')
  puts "Hello #{name.capitalize}!"
end

hello_world
hello 'World'
