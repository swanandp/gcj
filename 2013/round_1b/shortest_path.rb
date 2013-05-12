require 'priority_queue'

class Graph
  attr_accessor :vertices, :distances, :previous, :start, :finish
  def initialize
    @vertices = {}
  end

  def add_vertex(vertex, edges)
    @vertices[vertex] = edges
  end

  def shortest_path(start, finish)
    maxint = 1.0 / 0
    @start = start
    @finish = finish
    @distances = {}
    @previous = {}
    nodes = PriorityQueue.new

    @vertices.each do |vertex, edges|
      if vertex == @start
        @distances[vertex] = 0
        nodes[vertex] = 0
      else
        @distances[vertex] = maxint
        nodes[vertex] = maxint
      end
      @previous[vertex] = nil
    end

    while nodes.length > 0
      smallest = nodes.delete_min_return_key
      
      # nothing left or all infinite edges
      break if smallest == nil or @distances[smallest] == maxint
      
      @vertices[smallest].each do | neighbor, value |
        # cost of travelling
        alt = @distances[smallest] + value
        if alt < @distances[neighbor]
          @distances[neighbor] = alt
          @previous[neighbor] = smallest
          nodes[neighbor] = alt
        end
      end
    end
  end
  
  def path
    path = []
    current = @finish
    while @previous[current]
      path.push(current)
      current = @previous[current]
    end
    path.push(@start).reverse
  end
  
  def distance
    @distances[@finish]
  end
end

