# module for some enumerable methods
module Enumerable
  def my_each
    if block_given?
      for i in self
        yield(i)
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      for i in (0...length)
        yield(self[i], i)
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  def my_select
    new_array = []
    if block_given?
      my_each { |num| new_array << num if yield(num) }
      new_array
    else
      to_enum(:my_select)
    end
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
    counter = 0
    if args.size == 2 || args.size == 1 && block_given?
      counter = args[0]
      my_each do |x|
        next counter = counter.send(args[1], x) if args.length == 2

        counter = yield(counter, x)
      end
    else
      block_given?
      counter = self[0]
      self[1..-1].my_each do |x|
        next counter = yield(counter, x) if block_given?

        counter = counter.send(args[0], x)
      end
    end
    counter
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

# p (1..5).each { |n| "Current number is: #{n}" }==  (1..5).my_each { |n|  "Current number is: #{n}" }

# p [1,2,3,4,5,6,7,8,9,10].each_with_index{ |num, index| "#{num} is in #{index}"} == [1,2,3,4,5,6,7,8,9,10].my_each_with_index{ |num, index|  "#{num} is in #{index}"}
# p (1...6).my_select { |n| n.even? }== (1...6).select { |n| n.even? }
# p ((1..5).my_select { |x| x > 3 }) == ((1..5).select { |x| x > 3 })

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

# arr = [1, 3, 3, 4, 5]
# p arr.my_inject(2) { |m, e| m + e }
# p arr.my_inject(2) { |m, e| m + e } == arr.inject(2) { |m, e| m + e }
# p arr.my_inject { |m, e| m + e }
# p arr.my_inject { |m, e| m + e } == arr.inject { |m, e| m + e }
#  p arr.my_inject(2, :*)
# p arr.my_inject(2, :*) == arr.inject(2, :*)
#  p arr.my_inject(:+)
# p arr.my_inject(:+) == arr.inject(:+)

# p multiply_els([1, 2, 3])

# p [1, 2, 3, 4, 4, 7, 9].my_map { |i| i * 4 } == [1, 2, 3, 4, 4, 7, 9].map { |i| i * 4 }
# #

# p %w{ cat sheep bear }.my_inject {|memo, word| memo.length > word.length ? memo : word}
# p %w{cat sheep bear}.my_inject { |memo, word|
#   memo.length > word.length ? memo : word
# } == %w{cat sheep bear}.inject { |memo, word| memo.length > word.length ? memo : word }
# p (1..5).my_inject(2) { |product, n| product * n }
# p (1..5).my_inject(2) { |product, n| product * n } == (1..5).inject(2) { |product, n| product * n }
