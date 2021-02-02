require_relative("tree.rb")

tree = Tree.new(Array.new(20) {rand(100)})
tree.pretty_print
tree.balanced?
tree.level_order
tree.insert(Array.new(20) {rand(100)})
tree.pretty_print
tree.balanced?
tree.rebalance
tree.pretty_print
tree.balanced?
tree.level_order