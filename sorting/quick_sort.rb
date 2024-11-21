#!/usr/bin/env ruby

# [$]> ./quick_sort.rb

require 'test/unit'

def partition(arr, low, high)
  pivot = arr[high]
  pointer = low

  for idx in low...high do
    if arr[idx] <= pivot
      arr[pointer], arr[idx] = arr[idx], arr[pointer]
      pointer += 1
    end
  end

  arr[high] = arr[pointer]
  arr[pointer] = pivot

  pointer
end

def quick_sort(arr, low = 0, high = nil)
  high = arr.length - 1 if high.nil?

  if low < high
    pivot = partition(arr, low, high)
    quick_sort(arr, low, pivot - 1)
    quick_sort(arr, pivot + 1, high)
  end

  arr
end

arr = [3, 7, 8, 5, 2, 1, 9, 5, 4]
quick_sort(arr)
p arr

class Test_quick_sort < Test::Unit::TestCase
  def test_
    assert_equal [], quick_sort([])
    assert_equal [1], quick_sort([1])
    assert_equal [-10, 20], quick_sort([20, -10])
    assert_equal [1, 2, 3, 4, 5, 5, 7, 8, 9], quick_sort([3, 7, 8, 5, 2, 1, 9, 5, 4])
    assert_equal (1..10).to_a, quick_sort((1..10).to_a.shuffle)
  end
end
