#!/usr/bin/env ruby
# fair_and_square.rb

def next_palindrome(num)
  return num + 1 if num < 10
  length = num.to_s.length
  odd_digits = length % 2 != 0
  left_half = get_left_half(num)
  middle = get_middle(num)
  if odd_digits
    increment = 10 ** (length / 2)
    new_num = "#{left_half}#{middle}#{left_half[0..-1].reverse}".to_i
  else
    increment = (1.1 * (10 ** (length / 2))).to_i
    new_num = "#{left_half}#{left_half[0..-1].reverse}".to_i
  end
  if new_num > num
    return new_num
  end
  if middle != '9'
    return new_num + increment
  else
    return next_palindrome(round_up(num))
  end
end

def get_left_half(num)
  return num.to_s[0..((num.to_s.length / 2) - 1)]
end
 
def get_middle(num)
  num.to_s[(num.to_s.length - 1) / 2]
end
 
def round_up(num)
  length = num.to_s.length
  increment = 10 ** (( length / 2 ) + 1)
  return (( num / increment ) + 1) * increment
end

class Integer
  def fair?
    return false unless to_s[0] == to_s[-1]
    to_s == to_s.reverse
  end
end

class Numeric
  def square?
    sqrt = Math.sqrt(self)
    sqrt.ceil == sqrt.floor && sqrt.to_i.fair?
  end
end

def generate_numbers(a, b)
  numbers = []
  numbers << a if a.fair? && a.square?
  next_number = next_palindrome(a)
  while(next_number <= b) do
    numbers << next_number if next_number.square?
    next_number = next_palindrome(next_number)
  end
  numbers << next_number if next_number.square?
  numbers
end

def run_case(a, b, f)
  @case_no += 1
  # This is statically generated list using the generate_numbers algorithm above
  @fair_and_square_numbers = [1, 4, 9, 121, 484, 10201, 12321, 14641, 40804, 44944, 1002001, 1234321, 4008004, 100020001, 102030201, 104060401, 121242121, 123454321, 125686521, 400080004, 404090404, 10000200001, 10221412201, 12102420121, 12345654321, 40000800004]
  count = @fair_and_square_numbers.count { |n| n >= a && n <= b }
  f.puts "Case ##{@case_no}: #{count}"
end

count = 0
@case_no = 0
@fair_and_square_numbers = []
outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
ARGF.each do |line|
  count += 1
  next if count == 1
  a, b = line.strip.split(' ').map(&:to_i)
  run_case(a, b, f)
end
f.close
