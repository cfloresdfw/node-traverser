require "NodeT/version"

module NodeTraverser

  def self.calculateUniqueNodes(nodes, counter=0, uniqueNodes=nil)
    raise ArgumentError if nodes.nil?
    puts "counter passed: " + counter.to_s
    if uniqueNodes[counter].nil?
      puts "uniqueNodes is nil"
      uniqueNodes[counter] = Array.new([[nodes]])
    else
      puts "uniqueNodes is not nil"
      uniqueNodes[counter] << nodes unless uniqueNodes[counter].include?(nodes)
    end

    #uniqueNodes = Array.new
    #uniqueNodes << nodes unless uniqueNodes.include?(nodes)

    puts "==================="
    puts "working with node: " + nodes.object_id.to_s
    uniqueNodes[counter].each {|xx| puts "node in uniqueNodes: " + xx.object_id.to_s}
    nodes.listNodes.each do |node|
      puts "children of node: " + nodes.object_id.to_s + " is: " + node.object_id.to_s
      unless uniqueNodes[counter].include?(node)
        puts "adding node: " + node.object_id.to_s + " to uniqueNodes"
        puts "counter: " + counter.to_s
        uniqueNodes[counter] << node
        calculateUniqueNodes(node,counter,uniqueNodes)
        #calculateUniqueNodes(node)
      end
    end
    uniqueNodes[counter].length
  end

  class Node
    attr_accessor :listNodes
    #include NodeTraverser

    def initialize()
      self.listNodes = Array.new
      puts "node id: " + self.object_id.to_s
    end

    def addNodeToList(node)
      listNodes.push(node)
    end
=begin
    def self.calculateUniqueNodes(nodes, counter=nil, uniqueNodes=nil)
        raise ArgumentError if nodes.nil?
        if uniqueNodes.nil?
          uniqueNodes = Array.new([nodes])
        else
          puts "uniqueNodes is not nil"
          uniqueNodes << nodes
        end
        counter = 1 if counter.nil?

        puts "==================="
        puts "working with node: " + nodes.object_id.to_s
        uniqueNodes.each {|xx| puts "node in uniqueNodes: " + xx.object_id.to_s}
        nodes.listNodes.each do |node|
          puts "children of node: " + nodes.object_id.to_s + " is: " + node.object_id.to_s
          unless uniqueNodes.include?(node)
            puts "adding node: " + node.object_id.to_s + " to uniqueNodes"
            counter += 1
            puts "counter: " + counter.to_s
            uniqueNodes << node
            calculateUniqueNodes(node,counter,uniqueNodes)
          end
          #calculateUniqueNodes(node,counter,uniqueNodes)
        end
        puts "uniqueNodes length: " + uniqueNodes.size.to_s
        uniqueNodes.length

      end
=end
  end
end
