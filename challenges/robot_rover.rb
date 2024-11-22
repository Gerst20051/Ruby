#!/usr/bin/env ruby

# [$]> ./robot_rover.rb

TURN_LEFT_COMMAND = 'L'.freeze
TURN_RIGHT_COMMAND = 'R'.freeze
MOVE_FORWARD_COMMAND = 'M'.freeze
NEW_ROBOT_COMMAND = 'N'.freeze
HELP_COMMAND = '?'.freeze
VALID_COMMANDS = [TURN_LEFT_COMMAND, TURN_RIGHT_COMMAND, MOVE_FORWARD_COMMAND, NEW_ROBOT_COMMAND, HELP_COMMAND, '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].freeze
QUIT_COMMAND = 'Q'.freeze

NORTH = 'NORTH'.freeze
EAST = 'EAST'.freeze
SOUTH = 'SOUTH'.freeze
WEST = 'WEST'.freeze

class RobotRover
  def initialize(index)
    @index = index
    @position = [0, 0]
    @direction = NORTH
  end

  def run
    output_position
    self
  end

  def turn_left
    @direction = case @direction
      when NORTH then WEST
      when EAST then NORTH
      when SOUTH then EAST
      when WEST then SOUTH
    end
    output_position
  end

  def turn_right
    @direction = case @direction
      when NORTH then EAST
      when EAST then SOUTH
      when SOUTH then WEST
      when WEST then NORTH
    end
    output_position
  end

  def move_forward
    @position = case @direction
      when NORTH then [@position[0], @position[1] + 1]
      when EAST then [@position[0] + 1, @position[1]]
      when SOUTH then [@position[0], @position[1] - 1]
      when WEST then [@position[0] - 1, @position[1]]
    end
    output_position
  end

  def output_position
    puts "Robot #{@index} at #{@position} facing #{@direction}"
  end
end

class RobotManager
  def initialize
    @robots = []
    @robot_index = 0
  end

  def run
    output_welcome_message
    help
    new_robot
  end

  def run_command(command, *args)
    case command
      when TURN_LEFT_COMMAND then turn_left
      when TURN_RIGHT_COMMAND then turn_right
      when MOVE_FORWARD_COMMAND then move_forward
      when NEW_ROBOT_COMMAND then new_robot
      when HELP_COMMAND then help
      when '#0' then select_robot(0)
      when '#1' then select_robot(1)
      when '#2' then select_robot(2)
      when '#3' then select_robot(3)
      when '#4' then select_robot(4)
      when '#5' then select_robot(5)
      when '#6' then select_robot(6)
      when '#7' then select_robot(7)
      when '#8' then select_robot(8)
      when '#9' then select_robot(9)
      else puts "Invalid Command '#{command}' Skipped"
    end
  end

  def output_quit_message
    puts 'Robot shutting down.'
  end

  private

  def turn_left
    @robots[@robot_index].turn_left
  end

  def turn_right
    @robots[@robot_index].turn_right
  end

  def move_forward
    @robots[@robot_index].move_forward
  end

  def new_robot
    robots_count = @robots.count
    @robots.append RobotRover.new(robots_count).run
    @robot_index = robots_count
  end

  def select_robot(index)
    @robot_index = index
  end

  def output_welcome_message
    puts 'Hello! Robot coming online.'
  end

  def help
    puts """Command the robot with:
  L - turn left
  R - turn right
  M - move forward
  N - new robot
  # - select robot (0-9)
  ? - this message
  Q - quit"""
  end
end

class ReplLoop
  def initialize
    @robot_manager = RobotManager.new
    @should_output_commands = false
  end

  def run
    @robot_manager.run
    check_stdin
    repl_loop
  end

  private

  def check_stdin
    return unless $stdin.stat.pipe?

    @should_output_commands = true
    input = $stdin.read

    commands = input.split "\n"
    commands.each do |command|
      arguments = command.split
      @robot_manager.run_command(*arguments)
    end

    exit
  end

  def repl_loop
    loop do
      input = $stdin.readlines.join.chomp

      if input.upcase == QUIT_COMMAND
        @robot_manager.output_quit_message
        exit
      end

      commands = input.split "\n"
      @should_output_commands = true if commands.count > 1
      puts '===== OUTPUT BELOW =====' if commands.count > 1
      commands.each do |command|
        arguments = command.split
        @robot_manager.run_command(*arguments)
      end
      @should_output_commands = false if commands.count > 1
    end
  end
end

ReplLoop.new.run
