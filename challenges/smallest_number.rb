#!/usr/bin/env ruby

# Write a function that, given an array A of N integers, returns the smallest positive integer (greater than 0) that does not occur in A.
# For example, given A = [1, 3, 6, 4, 1, 2], the function should return 5.
# Given A = [1, 2, 3], the function should return 4.
# Given A = [-1, -3], the function should return 1.

def smallest_number(arr)
  smallest_num = 1
  arr.sort.each do |num|
    smallest_num += 1 if num == smallest_num
  end
  smallest_num
end

puts smallest_number([1, 3, 6, 4, 1, 2]) == 5
puts smallest_number([1, 2, 3]) == 4
puts smallest_number([-1, -3]) == 1
