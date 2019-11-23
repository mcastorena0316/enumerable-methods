# module for some enumerable methods
module Enumerable
  def self.my_each(array)
    new_array = []
    i = 0
    while i < array.length
      new_array << yield(array[i])
      i += 1
    end
    new_array
  end

  def self.my_each_with_index(array)
    new_array2 = []
    i = 0
    while i < array.length
      new_array2 << yield(array[i], i)
      i += 1
    end
    new_array2
  end

  def self.my_select(array)
    new_array3 = []
    i = 0
    while i < array.length
      new_array3 << array[i] if yield(array[i]) == true
      i += 1
    end
    new_array3
  end

  def self.my_all?(yen)
    i = 0
    while i < yen.length
      return false if yield(yen[i]) == false || yield(yen[i]).nil?

      i += 1
    end
    true
  end

  def self.my_any?(yen)
    contador = 0
    i = 0
    while i < yen.length
      contador += 1 if yield(yen[i]) == true
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

p Enumerable.my_each([1, 2, 3, 4]) { |x| x }
p Enumerable.my_each_with_index(%w[Cool chick beans]) { |item, index|
  "my word is #{item} and im in position #{index}"
}
p Enumerable.my_select([1, 2, 3, 4, 5, 6, 8, 100]) { |item| (item % 2).zero? }
p Enumerable.my_all?([1, 2, 3, 4, 5, 8]) { |x| x < 6 }
p Enumerable.my_any?([1, 2, 2, 4, 9]) { |x| x > 6 }
p Enumerable.my_none?([1, 0, 3, 2, 5, 4, 5, 6, 9, 30]) { |x| x > 10 }
p Enumerable.my_count([1, 2, 4, 2]) { |x| (x % 2).zero? }
# p Enumerable.my_map([2, 4, 6, 8, 100]) { |x| x * 2 }
p Enumerable.my_inject([8, 9, 2, 5, 6]) { |sum, number| sum * number }
p Enumerable.multiply_els([2, 4, 5, 7])
# mycall_proc = proc { |n| n * 2 }
# p Enumerable.my_map([1, 2, 3, 7, 4], mycall_proc)
mycall_proc = proc { |n| n * 2 }
p Enumerable.my_map([1, 2, 3, 4], mycall_proc)
p Enumerable.my_map([1, 2, 3, 8]) { |x| x * 2 }
