#!/usr/bin/env ruby
# fair_and_square.rb

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

def run_case(range, f)
  @case_no += 1
  fair_numbers = range.select { |n| n.fair? }
  count = fair_numbers.count do |num|
    if @fair_and_square_numbers.include?(num)
      true
    else
      if num.fair? && num.square?
        @fair_and_square_numbers << num
        true
      else
        false
      end
    end
  end
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
  run_case((a..b), f)
end
f.close
