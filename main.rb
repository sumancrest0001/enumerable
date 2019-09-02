# frozen_string_literal: true
module Enumerable
  def my_each
    counter=0
    while counter < self.size
      yield(self[counter])
      counter +=1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
    end
  end

  def my_select
    output = []
    my_each { |ele| output << ele if yield(ele) }
    output
  end

  def my_all?
    output = true
    my_each do |ele|
       if yield(ele) != true
         output = false
       end
    end
    output
  end

  def my_any?
    output = false
    my_each do |ele|
       if yield(ele) == true
         output = true
       end
     end
    output
  end

  def my_none?
    output = true
    my_each do |ele|
       if yield(ele) != false
         output = false
       end
    end
    puts output
  end

  def my_count(x = nil)
    count = 0
    if x == nil
      my_each { |ele| count +=1 }
    end
    my_each do |ele|
      if yield(ele, x)
        count += 1
      end
    end
    puts count
  end

  #initial version of my_map method
=begin
  def my_map(&procs)
    output = []
      self.my_each { |ele| output << procs.call(ele)}
     output
  end
=end

  def my_map(&procs)
    output = []
      my_each { |ele| output <<(procs.nil? ? yield(ele) : procs.call(ele))}
     output
  end

  def my_inject(x)
    sum = x
    my_each do |ele|
      sum = yield(ele, sum)
    end
    puts sum
  end

  def multiply_els
    my_inject(1){ |ele, sum| sum * ele }
  end
end
array = [1, 3, 24, 6, 2, 3, 3, 3, 29, 10, 1] # total sum = 85
modified_map = Proc.new { |ele| ele * ele }
# array.my_each { |i| puts "doubled number is: #{i * 2}" }
# array.my_each_with_index { |number, i| puts "index is #{i} and element is #{number}"}
# puts array.my_select { |ele| ele.odd? }
# array.my_all? { |ele| ele >= 2 }
# array.my_any? { |ele| ele >= 20 }
# array.my_none? { |ele| ele < 1 }
# array.my_count(3) { |ele, x| ele == x }
puts array.my_map { |ele| ele * ele }
puts array.my_map(&modified_map)
# array.my_inject { |ele, sum| sum += ele }
# array.multiply_els { |ele, sum| sum * ele }
