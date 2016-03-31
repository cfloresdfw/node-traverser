require "NodeT/version"

module NodeTraverser

  def self.calculateUniqueNodes(nodes, counter=0, uniqueNodes=nil)
    raise ArgumentError if nodes.nil?

    uniqueNodes = Array.new([]) if uniqueNodes.nil?

    if uniqueNodes[counter].nil?
      uniqueNodes[counter] = Array.new([nodes])
    else
      uniqueNodes[counter] << nodes unless uniqueNodes[counter].include?(nodes)
    end

    nodes.listNodes.each do |node|
      unless uniqueNodes[counter].include?(node)
        uniqueNodes[counter] << node
        calculateUniqueNodes(node,counter,uniqueNodes)
      end
    end
    uniqueNodes[counter].length
  end

  class Node
    attr_accessor :listNodes

    def initialize()
      self.listNodes = Array.new
    end

    def addNodeToList(node)
      listNodes.push(node)
    end
  end
end
