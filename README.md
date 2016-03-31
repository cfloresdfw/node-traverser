# NodeTraverser

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/NodeT`. To experiment with that code, run `bin/console` for an interactive prompt.

Use this gem to find out the number of unique nodes in a graph

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'node_traverser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install node_traverser

## Usage

1. Create a list of nodes using NodeTraverser::Node.new
ie: aNode = NodeTraverser::Node.new

2. Connect them with other nodes via the addNodeToList() method

ie:

    aNode.addNodeToList(bNode)
    aNode.addNodeToList(cNode)
    bNode.addNodeToList(cNode)
    cNode.addNodeToList(dNode)
    dNode.addNodeToList(aNode)


3. Once the list of nodes is created, use NodeTraverser.calculateUniqueNodes(aNodes) to calculate the number of unique nodes

see node_traverser_test.rb for more specifics.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/NodeT. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

