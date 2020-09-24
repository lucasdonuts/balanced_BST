require_relative 'lib/tree.rb'


array = Array.new(15) { rand(1..100)}
puts "\nArray: #{array}\n\n"
tree = Tree.new(array)
tree.pretty_print
puts "\nTree balanced? #{tree.balanced?}\n\n"
puts "Level order: #{tree.level_order}\n\n"
puts "Preorder: #{tree.preorder}\n\n"
puts "Postorder: #{tree.postorder}\n\n"
puts "Inorder: #{tree.inorder}\n\n"
tree.insert(101)
puts "Inserted 101"
tree.insert(133)
puts "Inserted 133"
tree.insert(999)
puts "Inserted 999\n\n\n"
tree.pretty_print
puts "\nTree balanced? #{tree.balanced?}\n\n"
tree.rebalance
puts "Rebalanced tree.\n\n"
tree.pretty_print
puts "\nLevel order: #{tree.level_order}\n\n"
puts "Preorder: #{tree.preorder}\n\n"
puts "Postorder: #{tree.postorder}\n\n"
puts "Inorder: #{tree.inorder}\n\n"