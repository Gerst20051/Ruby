#!/usr/bin/env ruby

# [$]> ./check_parentheses.rb

def check_parentheses(input)
  stack = []
  mapping = {
    ')' => '(',
    ']' => '[',
    '}' => '{',
  }
  for char in input.chars do
    unless '([{}])'.chars.include? char
      return false
    end
    if '([{'.chars.include? char
      stack.push char
    end
    if '}])'.chars.include? char
      unless stack.pop == mapping[char]
        return false
      end
    end
  end
  stack.empty?
end

puts check_parentheses('') == true
puts check_parentheses('])') == false
puts check_parentheses('})') == false
puts check_parentheses('()()') == true
puts check_parentheses('(())') == true
puts check_parentheses('((ab))') == false
puts check_parentheses(')(') == false
puts check_parentheses('()()') == true
puts check_parentheses('(())') == true
puts check_parentheses('(()(()))') == true
puts check_parentheses('((()))()()((()))') == true
puts check_parentheses('(du(dg))') == false
puts check_parentheses('ab') == false
puts check_parentheses(')(') == false
puts check_parentheses('(()((())') == false
puts check_parentheses('))()') == false
puts check_parentheses('((()))))') == false
puts check_parentheses('([{}])') == true
puts check_parentheses('([{])') == false
puts check_parentheses('([{()}])') == true
puts check_parentheses('([{( )}])') == false
