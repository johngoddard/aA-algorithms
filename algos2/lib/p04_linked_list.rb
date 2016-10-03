class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil?
  end

  def get(key)
    curr_node = @head.next

    while curr_node && curr_node.key != key
      curr_node = curr_node.next
    end

    curr_node ? curr_node.val : nil
  end

  def include?(key)
    curr_node = @head.next
    while curr_node && curr_node.key != key
      curr_node = curr_node.next
    end

    curr_node ? true : false
  end

  def insert(key, val)
    node = Link.new(key, val)
    if empty?
      @head.next = node
      @tail.prev = node
      node.prev = @head
      node.next = @tail
    else
      node.prev = @tail.prev
      @tail.prev.next = node
      node.next = @tail
      @tail.prev = node
    end
  end

  def remove(key)
    curr_node = @head.next

    while curr_node && curr_node.key != key
      curr_node = curr_node.next
    end

    if curr_node
      curr_node.next.prev = curr_node.prev if curr_node.next
      curr_node.prev.next = curr_node.next if curr_node.prev
    end
  end

  def each(&prc)
    current_node = @head.next
    until current_node == @tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
