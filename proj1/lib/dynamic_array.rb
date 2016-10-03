require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    val = @store[0]

    @length -= 1
    @length.times do |i|
      @store[i] = @store[i+1]
    end

    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length ==  @capacity
    (0...@length).to_a.reverse().each do |i|
      @store[i+1] = @store[i]
    end
    @store[0] = val
    @length += 1

    val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
  end

  def idx(i)

  end
end
