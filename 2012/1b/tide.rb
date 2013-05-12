#!/usr/bin/env ruby
# tide
$:.unshift File.dirname(__FILE__)
require 'shortest_path'

class Vertex
  attr_accessor :h, :f, :neighbours
  def initialize(h)
    @h = h
    @neighbours = []
  end

  def can_go_to_before_tide(v, level)
    # water level constraint: v.h - level > 20 &&
    # only needed in real time
    v.h - level > 20 && v.h - v.f > 20 && v.h - f > 20 && h - v.f > 20
  end

  def cannot_go_at_all(v)
    v.h - v.f <= 20 || v.h - f <= 20 || h - v.f <= 20
  end

  def cost(v)
    h - f >= 20 ? 1 : 10
  end
end

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |c|
  h, n, m = infile.readline.strip.split(' ').map(&:to_i)
  g = Graph.new(h)
  grid = []
  n.times do |i|
    grid << infile.readline.strip.split(' ').map { |ht| Vertex.new(ht.to_i) }
  end
  n.times do |i|
    infile.readline.strip.split(' ').each_with_index do |fl, j|
      grid[i][j].f = fl.to_i
    end
  end
  grid.each_with_index do |row, i|
    row.each_with_index do |column, j|
      edges = {}
      node = 10 * i + j
      [[i - 1, j], [i, j + 1], [i + 1, j], [i, j - 1]].each do |cell|
        if cell[0] >= 0 && cell[0] < n && cell[1] >=0 && cell[1] < m
          to_cell = grid[cell[0]][cell[1]]
          g.push(column)
          g.push(to_cell)
          if column.can_go_to_before_tide(to_cell, h)
            g.connect_mutually(column, to_cell, 0)
          else
            g.connect_mutually(column, to_cell, 1.0 / 0)
          end
        end
      end
    end
  end
  
  # puts g.distances
  # puts g.previous
  # puts g.distance
  # puts "=" * 100
  src = grid[0][0]
  dst = grid[n - 1][m - 1]
  f.puts "Case ##{c + 1}: #{g.dijkstra(src, dst)}"
end
infile.close
f.close
