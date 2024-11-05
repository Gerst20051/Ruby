#!/usr/bin/env ruby

# USAGE: ./process_orders.rb [INGESTION RATE (optional) (default: 2)]
# [$]> ./process_orders.rb
# [$]> ./process_orders.rb 1
# [$]> ./process_orders.rb 20

require 'json'

DEBUG_MODE = false
LOG_SHELVES = true

class OrdersSimulation
  attr_reader :shelves

  HOT = 'hot'
  COLD = 'cold'
  FROZEN = 'frozen'
  DEFAULT_INGESTION_RATE = 2
  SHELF_CAPACITY_REGULAR = 10
  SHELF_CAPACITY_OVERFLOW = 15

  def initialize(ingestion_rate)
    @ingestion_rate = ingestion_rate
    @shelves = {
      'hot': [],
      'cold': [],
      'frozen': [],
      'overflow': [],
    }
    @couriers = []
  end

  # load orders and start running the event loop
  def run
    load_orders
    run_loop
  end

  private

  # load orders from the json file
  def load_orders
    orders_file = File.open 'orders.json'
    @orders = JSON.load(orders_file)
    orders_file.close
  end

  # returns true if all temperature shelves are full
  def are_regular_shelves_full
    @shelves[:hot].length >= SHELF_CAPACITY_REGULAR && @shelves[:cold].length >= SHELF_CAPACITY_REGULAR && @shelves[:frozen].length >= SHELF_CAPACITY_REGULAR
  end

  # returns true if the overflow shelf is full
  def is_overflow_shelf_full
    @shelves[:overflow].length >= SHELF_CAPACITY_OVERFLOW
  end

  # returns true if all temperature shelves and the overflow shelf is full
  def are_all_shelves_full
    are_regular_shelves_full && is_overflow_shelf_full
  end

  # removes a random order from the overflow shelf
  def remove_random_order_from_overflow_shelf
    random_order_index = rand(SHELF_CAPACITY_OVERFLOW)
    log_event 'ORDER DISCARDED', @shelves[:overflow][random_order_index]
    @shelves[:overflow].delete_at(random_order_index)
  end

  # remove random orders from overflow shelf when its full and move orders to the correct temperature shelf from the overflow shelf
  def rearrange_shelves
    if are_all_shelves_full
      puts 'shelves are full' if DEBUG_MODE
      remove_random_order_from_overflow_shelf
      puts 'removed random order from overflow shelf' if DEBUG_MODE
    else
      puts 'shelves are not full' if DEBUG_MODE
      @shelves[:overflow].each_with_index do |order, index|
        if move_order_on_shelf(order)
          puts 'moved order from overflow shelf' if DEBUG_MODE
          @shelves[:overflow].delete_at(index)
          break
        end
      end
    end
  end

  # move orders from the overflow shelf to the correct temperature shelf
  def move_order_on_shelf(order)
    log_event 'ORDER MOVED', order
    shelf = shelves[order['temp'].to_sym]
    if shelf.length < SHELF_CAPACITY_REGULAR
      shelves[order['temp'].to_sym].append order
      return true
    end
    false
  end

  # place the order on the correct shelf according to the items temperature
  def place_order_on_shelf(order)
    shelf = shelves[order['temp'].to_sym]
    if shelf.length < SHELF_CAPACITY_REGULAR
      shelves[order['temp'].to_sym].append order
    else
      shelves[:overflow].append order
    end
  end

  # add item to couriers queue and assign pickup delay for the item
  def request_courier(order)
    pickup_delay_seconds = rand(2..6)
    courier_pickup_time = order['time'] + pickup_delay_seconds
    order['pickup_time'] = courier_pickup_time
    courier = [order['id'], order['pickup_time']]
    @couriers.append courier
    log_event 'COURIER REQUESTED', courier, false
    puts "requested courier for order #{order['id']} pick up time #{order['pickup_time']}" if DEBUG_MODE
  end

  # process orders after they have been received (rearrange shelves, place orders on shelves, and request courier)
  def process_order(order)
    log_event 'ORDER RECEIVED', order
    order['time'] = Time.now
    rearrange_shelves
    place_order_on_shelf(order)
    request_courier(order)
    puts "couriers length #{@couriers.length}" if DEBUG_MODE
  end

  # deliver an order after picked up by courier and remove order from the shelf
  def deliver_order(order_id)
    was_order_delivered = false
    @shelves.keys.each do |shelf|
      order_index = @shelves[shelf].index { |order| order['id'] == order_id }
      unless order_index.nil?
        log_event 'ORDER PICKED UP', @shelves[shelf][order_index]
        @shelves[shelf].delete_at(order_index)
        was_order_delivered = true
        break
      end
    end
    log_event 'ORDER NOT DELIVERED', order_id unless was_order_delivered
  end

  # check if any orders need to be delivered and give them to the couriers to pickup
  def check_couriers
    couriers_to_pickup = []
    @couriers.each_with_index do |courier, index|
      if courier[1] <= Time.now
        couriers_to_pickup.append index
      end
    end
    couriers_to_pickup.reverse.each do |courier_index|
      deliver_order(@couriers[courier_index][0])
      @couriers.delete_at(courier_index)
    end
  end

  # event loop for couriers to deliver orders and to process new orders
  def run_loop
    loop do
      check_couriers
      for i in 1..@ingestion_rate
        process_order @orders.shift unless @orders.empty?
      end
      log_event 'ALL ORDERS PROCESSED' if @orders.empty?
      sleep 1
      if @orders.empty? && @couriers.empty?
        break
      end
    end
  end

  # helper function to log events along with timestamp and optional data
  def log_event(name, data = nil, log_shelves = true)
    if data.nil?
      puts "#{Time.now} | #{name}"
    else
      puts "#{Time.now} | #{name} | #{data}"
    end
    puts JSON.pretty_generate(@shelves) if LOG_SHELVES && log_shelves
  end
end

INGESTION_RATE = ARGV[0].nil? ? OrdersSimulation::DEFAULT_INGESTION_RATE : ARGV[0].to_i

OrdersSimulation.new(INGESTION_RATE).run
