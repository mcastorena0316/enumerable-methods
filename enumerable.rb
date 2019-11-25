# module for some enumerable methods
module Enumerable
  def my_each
    return to_enum unless block_given?

    new_array = []
    i = 0
    while i < size
      new_array << yield(self[i])
      i += 1
    end
    new_array
  end

  def my_each_with_index
    return to_enum unless block_given?

    new_array2 = []
    i = 0
    while i < size
      new_array2 << yield(self[i], i)
      i += 1
    end
    new_array2
  end

  def my_select
    return to_enum unless block_given?

    new_array3 = []
    i = 0
    while i < size
      new_array3 << self[i] if yield(self[i]) == true
      i += 1
    end
    new_array3
  end

  def my_all?
    i = 0
    while i < size
      return false if yield(self[i]) == false || yield(self[i]).nil?

      i += 1
    end
    true
  end

  def my_any?
    contador = 0
    i = 0
    while i < size
      contador += 1 if yield(self[i]) == true
      i += 1
    end
    return false if contador.zero?

    true
  end

  def my_none?
    i = 0
    while i < size
      return false if yield(self[i]) == true

      i += 1
    end
    true
  end

  def my_count
    contador = 0
    i = 0
    while i < size
      contador += 1 if yield(self[i])

      i += 1
    end
    contador
  end

  def my_inject(start = 0)
    return to_enum unless block_given?

    result = start
    i = 0
    while i < size
      result = yield(result, (self[i]))
      i += 1
    end
    result
  end

  def my_map(*)
    new_array4 = []
    i = 0
    while i < size

      new_array4 << if block_given?
                      yield(self[i])
                    else
                      mycall_proc.call(self[i])
                    end
      i += 1
    end
    new_array4
  end
end

def multiply_els(array)
  array.my_inject(1) { |x, y| x * y }
end

p [1, 2, 3, 5].each { |x| x } == [1, 2, 3, 5].my_each { |x| x }

[1, 2, 3].my_each_with_index { |x, y| p x, y }
[1, 2, 3].each_with_index { |x, y| p x, y }

p [1, 2, 3, 4].my_select { |x| (x % 2).zero? } == [1, 2, 3, 4].select { |x| (x % 2).zero?  }

p ['alpha', 'apple', 'allen key'].my_all? { |x| x[0] == 'a' } == ['alpha', 'apple', 'allen key'].all? { |x| x[0] == 'a' }

p [1, 2, 2, 4, 7].any? { |x| x > 6 } == [1, 2, 2, 4, 7].my_any? { |x| x > 6 }

p [1, 2, 2, 4, 6].none? { |x| x > 6 } ==  [1, 2, 2, 4, 6].my_none? { |x| x > 6 }
p [1, 2, 3, 4, 4, 7, 7, 7, 9].count { |i| i > 1 } == [1, 2, 3, 4, 4, 7, 7, 7, 9].my_count { |i| i > 1 }

p [1, 2, 3, 4, 4, 7, 7, 7, 9].inject { |running_total, item| running_total + item } == [1, 2, 3, 4, 4, 7, 7, 7, 9].my_inject { |running_total, item| running_total + item }

p multiply_els([1, 2, 3])
p [1, 2, 3, 4, 4, 7, 9].my_map { |i| i * 4 } == [1, 2, 3, 4, 4, 7, 9].map { |i| i * 4 }
