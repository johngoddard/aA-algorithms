require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max;
  end

  def insert(num)
    validate!(num)
    @store[num] = true;
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    unless self[num].include?(num)
      self[num] << num
      num
    end
  end

  def remove(num)
    self[num].delete_if{|i| i == num}
  end

  def include?(num)
    self[num].include?(num) ? true : false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets

    unless include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete_if{ |i| i == num }
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num) ? true : false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets) { Array.new }

    @store.each do |arr|
      arr.each{|num| new_store[num % new_buckets] << num}
    end

    @store = new_store
  end
end
