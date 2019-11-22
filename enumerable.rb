
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

# p my_each(arr) {|x| x*2 }

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
