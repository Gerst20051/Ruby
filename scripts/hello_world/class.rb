#!/usr/bin/env ruby

class Hello
  def initialize(name = 'World')
    @name = name
  end

  def say_hi
    puts "Hi #{@name}!"
  end

  def say_bye
    puts "Bye #{@name}, come back soon."
  end
end

hello_world = Hello.new()
hello_world.say_hi
hello_world.say_bye

hello_andrew = Hello.new('Andrew')
hello_andrew.say_hi
hello_andrew.say_bye
