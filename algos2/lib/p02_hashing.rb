class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_sum = 0
    each_with_index do |el, i|
      hash_sum += i * el.hash
    end

    hash_sum
  end
end

class String
  def hash
    hash_sum = 0

    chars.each_with_index do |ch, idx|
      hash_sum += ((ch.ord + 1) ^ idx) * 1007
    end

    hash_sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted = self.to_a.sort
    hash_sum = 0
    sorted.each_with_index do |pair, idx|
      hash_sum += pair[0].hash + pair[1].hash
    end

    hash_sum
  end
end
