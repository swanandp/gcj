$:.unshift File.dirname(__FILE__)
require 'shortest_path'
require 'minitest/autorun'

class ShortestPath < MiniTest::Unit::TestCase
  def setup
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
  end

  def test_shortest_a_to_h
    @graph.shortest_path('A', 'E')
    assert_equal ['A', 'B', 'F', 'H', 'E'], @graph.path
  end

  def test_shortest_a_to_h_distance
    @graph.shortest_path('A', 'E')
    assert_equal 13, @graph.distance
  end

  def test_shortest_c_to_a
    @graph.shortest_path('C', 'A')
    assert_equal ['C', 'A'], @graph.path
  end

  def test_shortest_c_to_a_distance
    @graph.shortest_path('C', 'A')
    assert_equal 8, @graph.distance
  end

  def test_shortest_a_to_g
    @graph.shortest_path('A', 'G')
    assert_equal ['A', 'C', 'G'], @graph.path
  end

  def test_shortest_a_to_g_distance
    @graph.shortest_path('A', 'G')
    assert_equal 12, @graph.distance
  end


end
