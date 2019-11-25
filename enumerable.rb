# module for some enumerable methods
module Enumerable
  def my_each
    new_array = []
    i = 0
    while i < self.size
      new_array << yield(self[i])
      i += 1
    end
    new_array
  end

  def my_each_with_index
    new_array2 = []
    i = 0
    while i < self.size
      new_array2 << yield(self[i], i)
      i += 1
    end
    new_array2
  end

  def my_select
    new_array3 = []
    i = 0
    while i < self.size
      new_array3 << self[i] if yield(self[i]) == true
      i += 1
    end
    new_array3
  end

  def my_all?
    i = 0
    while i < self.size
      return false if yield(self[i]) == false || yield(self[i]).nil?

      i += 1
    end
    true
  end

  def my_any?
    contador = 0
    i = 0
    while i < self.size
      contador += 1 if yield(self[i]) == true
      i += 1
    end
    return false if contador.zero?

    true
  end

  def self.my_none?(yet)
    i = 0
    while i < yet.length
      return false if yield(yet[i]) == true

      i += 1
    end
    true
  end

  def self.my_count(men)
    contador = 0
    i = 0
    while i < men.length
      contador += 1 if yield(men[i])

      i += 1
    end
    contador
  end

  # def self.my_map(array)
  #   new_array = []
  #   i = 0
  #   while i < array.length
  #     new_array << yield(array[i])
  #     i += 1
  #   end
  #   new_array
  # end

  def self.my_inject(zin)
    result = 1
    i = 0
    while i < zin.length
      result = yield(result, (zin[i]))
      i += 1
    end
    result
  end

  def self.multiply_els(array)
    my_inject(array) do |sum, number|
      sum * number
    end
  end

  # def self.my_map(array, mycall_proc)
  #   new_array = []
  #   i = 0
  #   while i < array.length
  #     new_array << mycall_proc.call(array[i])
  #     i += 1
  #   end
  #   new_array
  # end

  def self.my_map(array, mycall_proc = nil)
    new_array4 = []
    i = 0
    while i < array.length

      new_array4 << if block_given?
                      yield(array[i])
                    else
                      mycall_proc.call(array[i])
                    end
      i += 1
    end
    new_array4
  end
end

# p Enumerable.my_any?([1, 2, 2, 4, 9]) { |x| x > 6 }
# p Enumerable.my_none?([1, 0, 3, 2, 5, 4, 5, 6, 9, 30]) { |x| x > 10 }
# p Enumerable.my_count([1, 2, 4, 2]) { |x| (x % 2).zero? }
# # p Enumerable.my_map([2, 4, 6, 8, 100]) { |x| x * 2 }
# p Enumerable.my_inject([8, 9, 2, 5, 6]) { |sum, number| sum * number }
# p Enumerable.multiply_els([2, 4, 5, 7])
# # mycall_proc = proc { |n| n * 2 }
# # p Enumerable.my_map([1, 2, 3, 7, 4], mycall_proc)
# mycall_proc = proc { |n| n * 2 }
# p Enumerable.my_map([1, 2, 3, 4], mycall_proc)
# p Enumerable.my_map([1, 2, 3, 8]) { |x| x * 2 }

# puts [1, 2, 3, 5].my_each { |x| p x }
# [1, 2, 3, 5].each { |x| p x } 
# [1, 2, 3, 5].my_each { |x| p x } 

# p [1, 2, 3, 5].each { |x|  x }  == [1, 2, 3, 5].my_each { |x|  x } 

p [1, 2, 3].my_each_with_index { |x, y|  x } ==  [1, 2, 3].each_with_index { |x, y|  x}

# p [1, 2, 3, 4].my_select { |x| x % 2 == 0} == [1, 2, 3, 4].select { |x| x % 2 == 0 }

# p ['alpha', 'apple', 'allen key'].my_all?{ |x| x[0] == 'a' }== ['alpha', 'apple', 'allen key'].all?{ |x| x[0] == 'a' }

# p [1, 2, 2, 4, 7].any?{ |x| x > 6 } == [1, 2, 2, 4, 7].my_any?{ |x| x > 6 }


