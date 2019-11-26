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

  def my_all?(pat = nil)
    result = true
    if block_given?
      my_each { |x| result = false unless yield(x) }
    elsif pat
      my_each { |x| result = false unless pattern?(x, pat) }
    else
      my_each { |x| result = false unless x }
    end
    result
  end

  def my_any?(pat = nil)
    result = false
    if block_given?
      my_each { |x| result = true if yield(x) }
    elsif pat
      my_each { |x| result = true if pattern?(x, pat) }
    else
      my_each { |x| result = true if x }
    end
    result
  end

  def my_none?(pat = nil)
    if block_given?
      !my_any? { |x| yield x }
    elsif pat
      !my_any?(pat)
    else
      my_each { |x| return false if x }
      true
    end
  end

  def my_count(src = nil)
    contador = 0
    if block_given?
      my_each { |x| contador += 1 if yield x }
    elsif src
      my_each { |x| contador += 1 if x == src }
    else
      my_each { contador += 1 }
    end
    contador
  end

  def my_inject(*args)
    x = args[0].nil? || args[0].class == Symbol ? 0 : args[0]
    sym = args[0].class == Symbol ? args[0] : args[1].class == Symbol ? args[1] : nil
    my_each do |elem|
      x = if sym
            x.send(sym, elem)
          else
            yield(x, elem)
          end
    end
    x
  end

  def my_map(*)
    return to_enum unless block_given?

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

  def pattern?(obj, pat)
    (obj.respond_to?(:eql?) && obj.eql?(pat)) ||
      (pat.is_a?(Class) && obj.is_a?(pat)) ||
      (pat.is_a?(Regexp) && pat.match(obj))
  end
end

def multiply_els(array)
  array.my_inject(1) { |x, y| x * y }
end

# p [1, 2, 3, 4].my_select { |x| (x % 2).zero? } == [1, 2, 3, 4].select { |x| (x % 2).zero? }

# # my_none
# p [1, 2, 2, 4, 1].my_none? { |x| x > 6 } == [1, 2, 2, 4, 1].none? { |x| x > 6 }
# p [nil, false, true].my_none? == [nil, false, true].none?
# p [nil, "hey", "hola"].my_none?(Numeric) == [nil, "hey", "hola"].none?(Numeric)
# p %w[ant bear cat].my_none?(/z/) == %w[ant bear cat].none?(/z/)

# # my_any
# p [1, 2, 2, 4, 4].my_any? { |x| x > 6 } == [1, 2, 2, 4, 4].any? { |x| x > 6 }
# p [nil, false, false].my_any? == [nil, false, false].any?
# p [nil, "hey", "hola"].my_any?(Numeric) == [nil, "hey", "hola"].any?(Numeric)
# p %w[ant bear cat].my_any?(/m/) == %w[ant bear cat].any?(/m/)

# # my all
# p [10, 20, 20, 40, 50].my_all? { |x| x > 6 } == [10, 20, 20, 40, 50].all? { |x| x > 6 }
# p [nil, true, true].my_all? == [nil, true, true].all?
# p [1, "hey", 3.14].my_all?(Numeric) == [1, "hey", 3.14].all?(Numeric)
# p %w[ant bear cat].my_all?(/m/) == %w[ant bear cat].all?(/m/)

# p [1, 2, 3, 4, 4, 7, 7, 7, 9].my_count { |i| i > 1 } == [1, 2, 3, 4, 4, 7, 7, 7, 9].count { |i| i > 1 }

# arr = [1, 2, 3, 4, 5]
# p arr.my_inject(2) { |m, e| m + e }
# p arr.my_inject { |m, e| m + e }
# p arr.my_inject(1, :*)
# p arr.my_inject(:+)

# p multiply_els([1, 2, 3])

# p [1, 2, 3, 4, 4, 7, 9].my_map { |i| i * 4 } == [1, 2, 3, 4, 4, 7, 9].map { |i| i * 4 }
