require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    calc!(key) unless @map.include?(key)
    link = @map[key]
    update_link!(link)
    return link.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    eject! if count == @max
    link = Link.new(key, @prc.call(key))
    @map[key] = link
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    link.prev.next = link.next if link.prev
    link.next.prev = link.prev if link.next
    link.next = @store.last
    link.prev = @store.last.prev
    link.prev.next = link
    @store.last.prev = link
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    to_remove = @store.first.next
    @store.first.next = @store.first.next.next
    @store.first.next.prev = @store.first
    @map.delete(to_remove.key)
  end
end
