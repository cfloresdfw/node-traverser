require 'test/unit'

require 'node_traverser'

class NodeTraverserTest < Test::Unit::TestCase

  def setup
    @nodeA = NodeTraverser::Node.new
    @nodeB = NodeTraverser::Node.new
    @nodeC = NodeTraverser::Node.new
    #@nodeD = NodeTraverser::Node.new
  end

  def teardown

  end

  def test_number_nodes_with_circular_links
    omit
    @nodeA.addNodeToList(@nodeB)
    @nodeA.addNodeToList(@nodeC)
    @nodeB.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeB)
    @nodeD.addNodeToList(@nodeA)
    @nodeD.addNodeToList(@nodeB)

    assert_equal(4,NodeTraverser::Node.calculateUniqueNodes(@nodeA),"Calculation failed")
  end

  def test_number_nodes_with_threads
    nodeAA = NodeTraverser::Node.new
    nodeBB = NodeTraverser::Node.new
    nodeCC = NodeTraverser::Node.new
    nodeDD = NodeTraverser::Node.new
    #nodeEE = NodeTraverser::Node.new
    #nodeFF = NodeTraverser::Node.new
    #nodeGG = NodeTraverser::Node.new

    #create the first set of nodes using local variables
    nodeAA.addNodeToList(nodeBB)

    nodeBB.addNodeToList(nodeCC)
    nodeBB.addNodeToList(nodeAA)

    nodeCC.addNodeToList(nodeDD)
    nodeCC.addNodeToList(nodeAA)
    nodeCC.addNodeToList(nodeBB)
=begin
    nodeDD.addNodeToList(nodeAA)
    nodeDD.addNodeToList(nodeBB)
    nodeDD.addNodeToList(nodeCC)
    nodeDD.addNodeToList(nodeEE)

    nodeEE.addNodeToList(nodeFF)
    nodeEE.addNodeToList(nodeAA)
    nodeEE.addNodeToList(nodeBB)
    nodeEE.addNodeToList(nodeCC)
    nodeEE.addNodeToList(nodeDD)

    nodeFF.addNodeToList(nodeGG)
    nodeFF.addNodeToList(nodeAA)
    nodeFF.addNodeToList(nodeBB)
    nodeFF.addNodeToList(nodeCC)
    nodeFF.addNodeToList(nodeDD)
    nodeFF.addNodeToList(nodeEE)

    nodeGG.addNodeToList(nodeAA)
    nodeGG.addNodeToList(nodeBB)
    nodeGG.addNodeToList(nodeCC)
    nodeGG.addNodeToList(nodeDD)
    nodeGG.addNodeToList(nodeEE)
    nodeGG.addNodeToList(nodeFF)
=end

    #second set of nodes using instance variables for the test

    @nodeA.addNodeToList(@nodeB)
    @nodeA.addNodeToList(@nodeC)
=begin
    @nodeB.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeB)
    @nodeD.addNodeToList(@nodeA)
=end
    threads = []
    uniqueNodes = Array.new([])

    i = 0
    [@nodeA, nodeAA].each do |t|
      threads[i] = Thread.new(t){
        NodeTraverser.calculateUniqueNodes(t,i,Array.new([i]))
      }
      i+=1
    end

=begin
    uniqueNodes[i] = Array.new([])
    threads[i] = Thread.new{
      NodeTraverser.calculateUniqueNodes(@nodeA,i,uniqueNodes[i])
    }

    i+=1

    uniqueNodes[i] = Array.new([[]])
    threads[i] = Thread.new{
      NodeTraverser.calculateUniqueNodes(nodeAA,i,uniqueNodes[i])
    }
=end
    puts "value of i: " + i.to_s

    threads.each{ |t| t.join }

    for nodes in uniqueNodes
      puts "hello there Nodes length: " + nodes.length.to_s unless nodes.nil?
    end

    assert_equal(3,threads[0].value,"Calculation failed")
    assert_equal(4,threads[1].value,"Calculation failed")

  end

  def test_one_node_only
    omit
    assert_equal(1,NodeTraverser::Node.calculateUniqueNodes(@nodeD),"Calculation failed")
  end

  def test_two_nodes_only_with_circular_links
    omit
    @nodeC.addNodeToList(@nodeD)
    @nodeD.addNodeToList(@nodeC)
    assert_equal(2,NodeTraverser::Node.calculateUniqueNodes(@nodeC),"Calculation failed")
  end

  def test_nil_node
    omit
    assert_raise(ArgumentError, "node is nil") {NodeTraverser::Node.calculateUniqueNodes(nil)}
  end

end