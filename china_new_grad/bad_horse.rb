#!/usr/bin/env ruby
# bad horse

def answer(possible)
  possible ? 'Yes' : 'No'
end

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |i|
  n = infile.readline.strip.to_i
  pairs = n.times.map { infile.readline.strip.split(' ') }
  people = pairs.flatten.uniq
  quarrels = {}
  # pass 1 prepare data
  pairs.each do |pair|
    m1, m2 = pair
    quarrels[m1] ||= []
    quarrels[m2] ||= []
    quarrels[m1] << m2 unless quarrels[m1].include?(m2)
    quarrels[m2] << m1 unless quarrels[m2].include?(m1)
  end

  # pass 2 analyze
  group1 = []
  group2 = []
  possible = true
  people.each do |person|
    if (group1 & quarrels[m1]).length == 0 && !group1.include?(m1)
      group1 << m1
    elsif (group2 & quarrels[m1]).length == 0 && !group2.include?(m1)
      group2 << m1
    else
      possible = false
      break
    end

    if (group1 & quarrels[m2]).length == 0 && !group1.include?(m2)
      group1 << m2
    elsif (group2 & quarrels[m2]).length == 0 && !group2.include?(m2)
      group2 << m2
    else
      possible = false
      break
    end
  end
  
  p 'group1: ' + '*' * 100
  p group1
  p 'group2: ' + '*' * 100
  p group2
  p 'people: ' + '*' * 100
  p people
  p 'quarrels: ' + '*' * 100
  p quarrels
  
  p '==' * 100
  f.puts "Case ##{i + 1}: #{answer(group1.length + group2.length == people.length)}"
end
f.close
