#Time to work on height and depth methods

require_relative 'node.rb'
require 'pry'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
    #puts "@root: #{@root.data}"
  end

  def build_tree(array, first = 0, last = array.length - 1)
    
    # base case
    if(first > last)
      return nil
    end

    mid = (first + last) / 2

    node = Node.new(array[mid])
    #p "Node: #{node.data}"
    root ||= node
    #p "Root: #{root.data}"

    node.left = build_tree(array, first, mid - 1)
    #p "Left: #{node.left}"
    node.right = build_tree(array, mid + 1, last)
    #p "Right: #{node.right}"

    return root

  end

  def find(value, root = @root)
    if root == nil || root.data == value
      return root
    elsif root.data < value
      find(value, root.right)
    else
      find(value, root.left)
    end
  end

  def insert(data, root = @root)
    #puts "Root: #{root.data}"
    if root == nil
      return root = Node.new(data)
    else
      if root.data == data
        return root
      elsif root.data < data
        root.right = insert(data, root.right)
      else
        root.left = insert(data, root.left)
      end
    end
    return root
  end

  def min_value_node(node)
    current = node

    while current.left != nil
      current = current.left
    end

    return current
  end

  def delete(data, root = @root)
    if root == nil
      return root
    end

    if data < root.data
      root.left = delete(data, root.left)
    elsif data > root.data
      root.right = delete(data, root.right)
    else
      if root.left == nil
        copy = root.right
        root.right = nil
        return copy
      elsif root.right == nil
        copy = root.left
        root.left = nil
        return copy
      else
        copy = min_value_node(root.right)
        root.data = copy.data
        root.right = delete(copy.data, root.right)
      end
    end
    return root
  end

  def level_order(root = @root, array = [], level = 0)
    return array unless root

    array << [] if array.length == level
    array[level] << root.data
    level_order(root.left, array, level + 1)
    level_order(root.right, array, level + 1)
  end

  def inorder(root = @root, array = [])
    return array unless root
    inorder(root.left, array)
    array << root.data
    inorder(root.right, array)
  end

  def preorder(root = @root, array = [])
    return array unless root
    array << root.data
    preorder(root.left, array)
    preorder(root.right, array)
  end

  def postorder(root = @root, array = [])
    return array unless root
    postorder(root.left, array)
    postorder(root.right, array)
    array << root.data
  end

  def height(node = @root.data)
    node = find(node)
    left_height = 0
    right_height = 0
    right = node
    left = node
    while left.left
      left_height += 1
      left = left.left
    end

    while right.right
      right_height += 1
      right = right.right
    end

    if left_height >= right_height
      return left_height
    else
      return right_height
    end

  end

  def depth(node, root = @root, depth = 0)
    if root == nil || root.data == node
      return depth
    elsif root.data < node
      depth += 1
      depth(node, root.right, depth)
    else
      depth += 1
      depth(node, root.left, depth)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(array)
#tree.pretty_print
tree.insert(32)
#tree.pretty_print
tree.delete(8)
tree.pretty_print
#puts "@root: #{tree.root.data}"
#puts tree.find(23)
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder
p tree.height
p tree.height(67)
p tree.height(5)
p "Depth of 9: #{tree.depth(9)}"
p "Depth of 67: #{tree.depth(67)}"
p "Depth of 5: #{tree.depth(5)}"