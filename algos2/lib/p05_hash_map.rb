require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    delete(key) if include?(key)
    resize! if @count == num_buckets
    bucket(key).insert(key, val)
    @count += 1
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |list|
      list.each { |link| prc.call([link.key, link.val]) }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets){ LinkedList.new }

    @store.each do |list|
      list.each{|link| new_store[link.key.hash % new_buckets].insert(link.key, link.val)}
    end

    @store = new_store

  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
