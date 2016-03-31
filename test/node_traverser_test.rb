require 'test/unit'

require 'node_traverser'

class NodeTraverserTest < Test::Unit::TestCase

  def setup
    @nodeA = NodeTraverser::Node.new
    @nodeB = NodeTraverser::Node.new
    @nodeC = NodeTraverser::Node.new
    @nodeD = NodeTraverser::Node.new
  end

  def teardown
    #empty for now
  end

  def test_number_nodes_with_circular_links

    @nodeA.addNodeToList(@nodeB)
    @nodeA.addNodeToList(@nodeC)
    @nodeB.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeB)
    @nodeD.addNodeToList(@nodeA)
    @nodeD.addNodeToList(@nodeB)

    assert_equal(4,NodeTraverser.calculateUniqueNodes(@nodeA),"Calculation failed")
  end

  def test_number_nodes_with_threads
    nodeAA = NodeTraverser::Node.new
    nodeBB = NodeTraverser::Node.new
    nodeCC = NodeTraverser::Node.new
    nodeDD = NodeTraverser::Node.new
    nodeEE = NodeTraverser::Node.new
    nodeFF = NodeTraverser::Node.new
    nodeGG = NodeTraverser::Node.new

    #create the first set of nodes using local variables
    nodeAA.addNodeToList(nodeBB)

    nodeBB.addNodeToList(nodeCC)
    nodeBB.addNodeToList(nodeAA)

    nodeCC.addNodeToList(nodeDD)
    nodeCC.addNodeToList(nodeAA)
    nodeCC.addNodeToList(nodeBB)

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

    #second set of nodes using instance variables for the test

    @nodeA.addNodeToList(@nodeB)
    @nodeA.addNodeToList(@nodeC)
    @nodeB.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeD)
    @nodeC.addNodeToList(@nodeB)
    @nodeD.addNodeToList(@nodeA)

    threads = []
    uniqueNodes = Array.new([])

    i = 0
    [@nodeA, nodeAA].each do |n|
      threads[i] = Thread.new(n){
        NodeTraverser.calculateUniqueNodes(n,i,Array.new([i]))
      }
      i+=1
    end

    threads.each{ |t| t.join }

    assert_equal(4,threads[0].value,"Calculation failed")
    assert_equal(7,threads[1].value,"Calculation failed")

  end

  def test_one_node_only
    assert_equal(1,NodeTraverser.calculateUniqueNodes(@nodeD),"Calculation failed")
  end

  def test_two_nodes_only_with_circular_links
    @nodeC.addNodeToList(@nodeD)
    @nodeD.addNodeToList(@nodeC)
    assert_equal(2,NodeTraverser.calculateUniqueNodes(@nodeC),"Calculation failed")
  end

  def test_nil_node
    assert_raise(ArgumentError, "node is nil") {NodeTraverser.calculateUniqueNodes(nil)}
  end

end