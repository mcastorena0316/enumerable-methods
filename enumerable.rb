
#  module Enumerable
#   def my_each
#     # your code here
#   end
# end

# #my_each 
# def my_each(array) 
#   newArray= []

#   for i in  0..array.length-1 do 
#    newArray << yield(array[i])
#   end
#   return newArray
# end


# arr=[1,2,3,4]

# p my_each(arr) {|x| x }

# #my each
# def my_each_with_index(array)
#   newArray2= []
#   for i in  0..array.length-1 do 
#     newArray2 << yield(array[i],i)
#   end
#   return newArray2
# end

# arr2=["Cool", "chicken!", "beans!", "beef!"]
# arr3= [1,2,3,4,]

#  p my_each_with_index(arr2) { |item, index|
# "my word is #{item} and im in position #{index}" }

# p my_each_with_index(arr3)   { |item, index|
# "my number is #{item} and im in position #{index}" }

# # my_select

# def my_select(array)
#   newArray3= []
#   for i in  0..array.length-1 do 
#   if yield(array[i]) == true 
#     newArray3 << array[i]
#   end
# end
# return newArray3

# end

# my_array = [1,2,3,4,5,6,7,8,100]

# p my_select(my_array){|item| item%2==0 }

# enu1 = [10, 19, 18]    

#my all
# def my_all?(y)
#   for i in  0..y.length-1 do
#     if yield(y[i]) == false || yield(y[i]) == nil
#      return false
#     end
#   end
# true
# end 



# numbers = [1, 2, 3, 4, 5, 7]

#  p my_all?(numbers){ |x| x < 6 }

 #my_any?
#  def my_any?(y)
#   contador= 0
#   for i in  0..y.length-1 do
#     if yield(y[i]) == true 
#       contador += 1 
#     end 
#     if contador == 0   then
#       return false 
#     end  
#   end
  
# end 
 
# numbers2 = [1, 2, 3, 4, 5]

# p my_any?(numbers2){ |x| x > 6 }

 #my_none?
#   def my_none?(y)

#   for i in  0..y.length-1 do
#     if yield(y[i]) == true 
#       return false
#     end  
#   end
#   true
# end 
 
# numbers3 = [1, 0, 3, 2, 5, 4, 7, 6, 9, 8]
# p my_none?(numbers3){ |x| x > 10 }

#my count
# def my_count(m)
#     contador= 0
#     for i in  0..m.length-1 do
#       if yield(m[i]) then
#        contador += 1 
#       end
#   end 
#   return contador
# end
     
#   ary = [1, 2, 4, 2]
    
# p my_count(ary){ |x| x%2==0 }

#my_map 
# def my_map(array) 
#     newArray= []
  
#     for i in  0..array.length-1 do 
#      newArray << yield(array[i])
#     end
#     return newArray
#   end
#  test= [2,4,6,8,100] 

#  p my_map(test) {|x| x*2 }

# my_inject
def my_inject(z)
result= 1
  for i in  0..z.length-1 do 
     result=yield(result,(z[i]))
  end
  return result
  
end

# test2=[8,9,2,5,6]
# p my_inject(test2) {|sum,number| sum * number }



def multiply_els(array)

  return my_inject(array) do |sum, number| 
   sum* number
  end

end

 p multiply_els([2,4,5,7])


