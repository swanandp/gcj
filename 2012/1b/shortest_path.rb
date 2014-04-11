#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class Edge
  attr_accessor :src, :dst, :length
  
  def initialize(src, dst, length = 1)
    @src = src
    @dst = dst
    @length = length
  end
end

class Graph < Array
  attr_reader :edges, :level
  
  def initialize(level)
    @level = level
    @edges = []
  end
  
  def connect(src, dst, length = 1)
    unless self.include?(src)
      raise ArgumentException, "No such vertex: #{src}"
    end
    unless self.include?(dst)
      raise ArgumentException, "No such vertex: #{dst}"
    end
    @edges.push Edge.new(src, dst, length)
  end
  
  def connect_mutually(vertex1, vertex2, length = 1)
    self.connect vertex1, vertex2, length
    self.connect vertex2, vertex1, length
  end

  def neighbors(vertex)
    neighbors = []
    @edges.each do |edge|
      neighbors.push edge.dst if edge.src == vertex
    end
    return neighbors.uniq
  end

  def length_between(src, dst, level)
    return nil if src.cannot_go_at_all(dst)
    new_level = level - ( dst.h - 50 )
    wait_time = new_level / 10.0
    if new_level - src.f >= 20
      wait_time + 1
    else
      wait_time + 10
    end
  end

  def dijkstra(src, dst = nil)
    distances = {}
    previouses = {}
    self.each do |vertex|
      distances[vertex] = nil # Infinity
      previouses[vertex] = nil
    end
    distances[src] = 0
    vertices = self.dup
    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      # do not need this, since in our case, it is always going to be present
      # break unless distances[nearest_vertex] # Infinity
      if dst and nearest_vertex == dst
        return distances[dst]
      end
      neighbors = vertices.neighbors(nearest_vertex)
      neighbors.each do |vertex|
        cost = vertices.length_between(nearest_vertex, vertex, (@level - distances[nearest_vertex] * 10))
        next unless cost
        alt = distances[nearest_vertex] + cost
        if distances[vertex].nil? or alt < distances[vertex]
          distances[vertex] = alt
          previouses[vertices] = nearest_vertex
          # decrease-key v in Q # ???
        end
      end
      vertices.delete nearest_vertex
    end
    if dst
      return nil
    else
      return distances
    end
  end
end

# graph = Graph.new
# (1..6).each {|node| graph.push node }
# graph.connect_mutually 1, 2, 7
# graph.connect_mutually 1, 3, 9
# graph.connect_mutually 1, 6, 14
# graph.connect_mutually 2, 3, 10
# graph.connect_mutually 2, 4, 15
# graph.connect_mutually 3, 4, 11
# graph.connect_mutually 3, 6, 2
# graph.connect_mutually 4, 5, 6
# graph.connect_mutually 5, 6, 9
# 
# p graph
# p graph.length_between(2, 1)
# p graph.neighbors(1)
# p graph.dijkstra(1, 5)
