#!/usr/bin/env ruby

# [$]> ./task_manager.rb

class Task
  def initialize(lambda = nil)
    # generate and assign a random task id
    # @id = 
    # @lambda = lambda
  end

  def run
    # invoke the lambda
  end
end

class Worker
  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def get_task_count
    @tasks.length
  end

  def add_task(task)
    @tasks.append task
  end
end

class TaskManager
  attr_reader :tasks
  attr_reader :workers

  def initialize(tasks, workers)
    @tasks = tasks
    @workers = workers
    run_loop
  end

  def assign_task_to_worker
    if @tasks.length > 0 && @workers.length > 0
      worker = @workers.sort { |a, b| a.get_task_count - b.get_task_count }.first
      worker.add_task(@tasks.shift)
    end
  end

  def run_loop
    loop do
      assign_task_to_worker
      puts 'REMAINING TASK COUNT'
      puts @tasks.length
      @workers.each do |worker|
        puts 'WORKER TASKS'
        puts worker.tasks
      end
      break unless @tasks.length > 0
      # sleep 1
    end
  end
end

class AssertionError < StandardError; end

def assert_equal(expected, actual)
  raise AssertionError.new("Expected #{expected}, but got #{actual}") unless expected == actual
end

task_manager_v0 = TaskManager.new([], [])
assert_equal(0, task_manager_v0.workers.length)

task_manager_v1 = TaskManager.new([Task.new, Task.new, Task.new], [Worker.new, Worker.new, Worker.new])
assert_equal(0, task_manager_v1.tasks.length)
task_manager_v1.workers.each do |worker|
  assert_equal(1, worker.tasks.length)
end

task_manager_v2 = TaskManager.new([Task.new, Task.new, Task.new], [Worker.new])
assert_equal(3, task_manager_v2.workers.first.tasks.length)
