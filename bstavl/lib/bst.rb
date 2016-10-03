class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      BinarySearchTree.insert!(@root, value)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
      BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node

    if value <= node.value
      if node.left
        BinarySearchTree.insert!(node.left, value)
      else
        to_insert = BSTNode.new(value)
        node.left = to_insert
      end
    else
      if node.right
        BinarySearchTree.insert!(node.right, value)
      else
        to_insert = BSTNode.new(value)
        node.right = to_insert
      end
    end

    node
  end

  def self.find!(node, value)
    return nil unless node

    if node.value == value
      return node
    elsif node.value > value
      return BinarySearchTree.find!(node.left, value)
    else
      return BinarySearchTree.find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] unless node

    left_ordered = BinarySearchTree.inorder!(node.left)
    right_ordered = BinarySearchTree.inorder!(node.right)

    [node.value] + left_ordered + right_ordered
  end

  def self.inorder!(node)
    return [] unless node
    left_ordered = BinarySearchTree.inorder!(node.left)
    right_ordered = BinarySearchTree.inorder!(node.right)

    left_ordered + [node.value] + right_ordered
  end

  def self.postorder!(node)
    return [] unless node

    left_ordered = BinarySearchTree.inorder!(node.left).reverse
    right_ordered = BinarySearchTree.inorder!(node.right).reverse

    left_ordered + right_ordered + [node.value]
  end

  def self.height!(node)
    return -1 unless node
    return 0 unless node.left || node.right
    ([BinarySearchTree.height!(node.left), BinarySearchTree.height!(node.right)].max) + 1
  end

  def self.max(node)
    return nil unless node

    until node.right.nil?
      node = node.right
    end

    node
  end

  def self.min(node)
    return nil unless node
    until node.left.nil?
      node = node.left
    end

    node
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left

    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil unless node

    if node.value == value
      return node.left unless node.right
      return node.right unless node.left

      min_node = BinarySearchTree.min(node.right)
      min_node.right = node.right
      min_node.left = BinarySearchTree.delete_min!(node.right)

      return min_node
    elsif node.value > value
      node.left = BinarySearchTree.delete!(node.left, value)
    else
      node.right = BinarySearchTree.delete!(node.right, value)
    end

    node
  end
end
