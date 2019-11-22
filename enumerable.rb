
 module Enumerable

  def self.my_each(array) 
    newArray= []
    for i in  0..array.length-1 do 
    newArray << yield(array[i])
    end
    return newArray
  end

  def self.my_each_with_index(array)
    newArray2= []
    for i in  0..array.length-1 do 
      newArray2 << yield(array[i],i)
    end
    return newArray2
  end

  def self.my_select(array)
    newArray3= []
    for i in  0..array.length-1 do 
      if yield(array[i]) == true 
        newArray3 << array[i]
      end
    end
    return newArray3
  end

  def self.my_all?(y)
    for i in  0..y.length-1 do
      if yield(y[i]) == false || yield(y[i]) == nil
      return false
      end
    end
    true
  end 

  def self.my_any?(y)
    contador= 0
    for i in  0..y.length-1 do
      if yield(y[i]) == true 
        contador += 1 
      end 
    end  
    if contador == 0   then
      return false
    end
    true
  end 
 
  def self.my_none?(y)
    for i in  0..y.length-1 do
      if yield(y[i]) == true 
        return false
      end  
    end
    true
  end 

  def self.my_count(m)
      contador= 0
      for i in  0..m.length-1 do
        if yield(m[i]) then
        contador += 1 
        end
    end 
    return contador
  end
 
  # def self.my_map(array) 
  #   newArray= []
  #   for i in  0..array.length-1 do 
  #   newArray << yield(array[i])
  #   end
  #   return newArray
  # end

  def self.my_inject(z)
    result= 1
    for i in  0..z.length-1 do 
      result=yield(result,(z[i]))
    end
    return result  
  end

  def self.multiply_els(array)
    return my_inject(array) do |sum, number| 
    sum* number
    end
  end

  # def self.my_map(array, mycall_proc)
  #   newArray = []
  #   for i in  0..array.length-1 do 
  #     newArray << mycall_proc.call(array[i])
  #   end
  #   return newArray
  # end

def self.my_map(array, mycall_proc=nil)
  newArray4 = []
  for i in  0..array.length-1 do 
    if block_given?
      newArray4 << yield(array[i])
    else
      newArray4 << mycall_proc.call(array[i])
    end
  end
  return newArray4
end
end 

# p Enumerable.my_each([1,2,3,4]) {|x| x }
# p Enumerable.my_each_with_index(["Cool", "chicken!", "beans!", "beef!"]){ |item, index|
# "my word is #{item} and im in position #{index}" }
# p Enumerable.my_select([1,2,3,4,5,6,7,8,100]){|item| item%2==0 }
# p Enumerable.my_all?([1, 2, 3, 4, 5, 7]){ |x| x < 6 }
# p Enumerable.my_any?([1, 2, 60, 4, 11]){ |x| x > 6 }
# p Enumerable.my_none?([1, 0, 3, 2, 5, 4, 5, 6, 9, 8]){ |x| x > 10 }
# p Enumerable.my_count([1, 2, 4, 2]){ |x| x%2==0 }
# p Enumerable.my_map([2,4,6,8,100] ) {|x| x*2 }
# p Enumerable.my_inject([8,9,2,5,6]) {|sum,number| sum * number }
# p Enumerable.multiply_els([2,4,5,7])
# mycall_proc = Proc.new { |n| n*2 }
# p Enumerable.my_map([1,2,3,7,4], mycall_proc)
mycall_proc = Proc.new { |n| n*2 }
p Enumerable.my_map([1,2,3,4], mycall_proc)
p Enumerable.my_map([1,2,3,4]){|x| x*2 }




