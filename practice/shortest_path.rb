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

@graph = Graph.new
@graph.add_vertex('A', 'B' => 7, 'C' => 8)
@graph.add_vertex('B', 'A' => 7, 'F' => 2)
@graph.add_vertex('C', 'A' => 8, 'F' => 6, 'G' => 4)
@graph.add_vertex('D', 'F' => 8)
@graph.add_vertex('E', 'H' => 1)
@graph.add_vertex('F', 'B' => 2, 'C' => 6, 'D' => 8, 'G' => 9, 'H' => 3)
@graph.add_vertex('G', 'C' => 4, 'F' => 9)
# @graph.add_vertex('H', 'E' => 1, 'F' => 3)
@graph.add_vertex('H', 'F' => 3)

@graph.shortest_path('A', 'E')

puts @graph.path.inspect
puts @graph.distance.inspect
puts @graph.distances
puts @graph.previous
