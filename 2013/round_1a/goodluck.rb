#!/usr/bin/env ruby
# goodluck

require 'prime'

class Fixnum
 def prime_factors
   prime_division.inject([]) { |acc, f| acc += [f[0]] * f[1]; acc }
 end
end


outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
infile.readline.strip.to_i
r, n, m, k = infile.readline.strip.split(' ').map(&:to_i)
f.puts "Case ##{1}: "
r.times do
  products = infile.readline.strip.split(' ').map(&:to_i).uniq.select { |p| p > 1 }.sort
  if products.length == 0
    puts "#{rand(2..5)}#{rand(2..5)}#{rand(2..5)}"
    next
  end
  
  numbers = []
  products.each do |p|
    primes, powers = p.prime_division.transpose
    if primes.include?(3)
      numbers += [3] * powers[primes.index(3)] unless numbers.include?(3)
    end
    if primes.include?(5)
      numbers += [5] * powers[primes.index(5)] unless numbers.include?(5)
    end
    numbers << p if p.prime? && !numbers.include?(p)
    break if numbers.length == 3
  end
  puts "#{numbers.join}"
end
f.close
