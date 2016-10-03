require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[idx(index)]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[idx(index)] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    @store[idx(@length)]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[idx(@length)] = val
    @length += 1
    val
  end

  # O(1)
  def shift
    puts 'here'
    raise 'index out of bounds' if @length == 0
    el = @store[@start_idx]
    @start_idx = idx(1)
    @length -= 1
    el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = idx(-1)
    @store[@start_idx] = val
    @length += 1
    val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    @capacity.times{ |i| new_store[i] = @store[idx(i)]}

    @capacity *= 2
    @start_idx = 0
    @store = new_store
  end

  def idx(i)
    (@start_idx + i) % @capacity
  end
end
