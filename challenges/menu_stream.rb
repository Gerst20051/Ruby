#!/usr/bin/env ruby

# [$]> ./menu_stream.rb

class MenuStream
  attr_reader :test_stream

  def initialize
    @test_stream = ['4', 'DISH', 'Spaghetti', '10.95', '2', '3', '', '1', 'CATEGORY', 'Pasta', '4', '5', '', '2', 'OPTION', 'Meatballs', '1.00', '', '3', 'OPTION', 'Chicken', '2.00', '', '5', 'DISH', 'Lasagna', '12.00', '', '6', 'DISH', 'Caesar Salad', '9.75', '3', '']
  end

  def next_line
    test_stream.shift()
  end
end

class MenuItem
  attr_reader :id, :type, :name, :price

  def initialize
    @options = []
  end

  def set_id(id)
    @id = id
  end

  def set_type(type)
    @type = type
  end

  def set_name(name)
    @name = name
  end

  def set_price(price)
    @price = price
  end

  def add_option(option)
    @options.append option
  end

  def to_s
    "#{@id} #{@type} #{@name} #{@price} #{@options}"
  end
end

class Menu
  def initialize(menu_stream)
    @menu_items = []
    @item = MenuItem.new
    while true
      line = menu_stream.next_line
      break if line.nil?
      if line == ''
        @menu_items.append @item
        @item = MenuItem.new
        next
      end
      unless @item.id
        @item.set_id(line)
        next
      end
      unless @item.type
        @item.set_type(line)
        next
      end
      unless @item.name
        @item.set_name(line)
        next
      end
      if !@item.price && ['DISH', 'OPTION'].include?(@item.type)
        @item.set_price(line)
        next
      end
      @item.add_option(line)
    end
    puts @menu_items
  end
end

Menu.new(MenuStream.new)
