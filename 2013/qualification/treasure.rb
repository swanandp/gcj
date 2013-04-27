#!/usr/bin/env ruby
# treasure.rb

class Array
  def frequencies
    self.uniq.reduce({}) do |acc, i|
      acc[i] = self.count {|j| j == i }
      acc
    end
  end
end

class Chest
  attr_accessor :sr_no, :required_key, :num_keys, :keys
  def initialize(sr_no, chest)
    @sr_no = sr_no
    @required_key, @num_keys, *@keys = chest
  end
end

def run_case(chests, keys, f = Kernel)
  @sr_no += 1
  @scores = []
  simulate(chests, keys, [])
  if @scores.length == 0
    f.puts "Case ##{@sr_no}: IMPOSSIBLE"
  else
    f.puts "Case ##{@sr_no}: #{@scores.min.split('').join(' ')}"
  end
end

def simulate(chests, keys, sequence)
  if @target == sequence.length
    @scores << sequence.join
    return
  end
  openings = possible_openings(chests, keys)
  return if openings.length == 0
  
  needed_keys = chests.map(&:required_key).frequencies
  available_keys = (chests.map(&:keys).flatten + keys).frequencies
  return unless needed_keys.all? { |k, count| count <= available_keys[k].to_i }
  
  openings.each do |chest|
    _chests, _keys, _sequence = open_chest(chests, chest, keys, sequence)
    simulate(_chests, _keys, _sequence)
  end
  return
end

def possible_openings(chests, keys)
  chests.select { |c| 
    keys.include?(c.required_key) 
  }.sort{ |c1, c2| 
    c1.keys.length <=> c2.keys.length 
  }
end

def open_chest(chests, chest, keys, sequence)
  _keys = keys.dup
  _keys.delete_at(_keys.index(chest.required_key))
  [
    chests - [chest],
    _keys + chest.keys,
    sequence + [ chest.sr_no ]
  ]
end

count = 0
@case_no = 0
@case_counter = 0
@sr_no = 0
outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
chests = []
keys = []
ARGF.each do |line|
  count += 1
  next if count == 1
  if @case_counter == 0
    run_case(chests, keys, f) if chests.length > 0
    k, @target = line.strip.split(' ').map(&:to_i)
    @case_counter = 1 + @target
    chests = []
    keys = []
  elsif @case_counter == 1 + @target
    keys = line.strip.split(' ').map(&:to_i)
    @case_counter -= 1
  else
    chests << Chest.new(chests.length + 1, line.strip.split(' ').map(&:to_i))
    @case_counter -= 1
  end
end

run_case(chests, keys, f) if chests.length > 0
f.close
