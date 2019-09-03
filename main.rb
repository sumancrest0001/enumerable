# frozen_string_literal: true

module Enumerable
  def my_each
    counter = 0
    while counter < size
      yield(self[counter])
      counter += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
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
      output = false if yield(ele) != true
    end
    output
  end

  def my_any?
    output = false
    my_each do |ele|
      output = true if yield(ele) == true
    end
    output
  end

  def my_none?
    output = true
    my_each do |ele|
      output = false if yield(ele) == true
    end
    puts output
  end

  def my_count(number = nil)
    count = 0
    return size if number.nil? && !block_given?
    if number.nil? && block_given?
      my_each do |ele|
        count += 1 if yield(ele, number) == true
      end
    end
    if !number.nil? && block_given?
      my_each do |ele|
        count += 1 if yield(ele, number) == true
      end
    end
    count
  end

  def my_map(&procs)
    output = []
    my_each { |ele| output << (procs.nil? ? yield(ele) : procs.call(ele)) }
    output
  end

  def my_inject(startervalue)
    sum = startervalue
    my_each do |ele|
      sum = yield(ele, sum)
    end
    puts sum
  end

  def multiply_els
    my_inject(1) { |ele, sum| sum * ele }
  end
end
array = [2, 3, 4, 2]
# array = [1, 3, 24, 6, 2, 3, 3, 3, 29, 10, 1] # total sum = 85
# modified_map = proc { |ele| ele * ele }
# array.my_each { |i| puts "doubled number is: #{i * 2}" }
# array.my_each_with_index { |number, i| puts "index is #{i} and element is #{number}"}
# puts array.my_select { |ele| ele.odd? }
# array.my_all? { |ele| ele >= 2 }
# array.my_any? { |ele| ele >= 20 }
# array.my_none? { |ele| ele = 1 }
puts array.my_count(2){ |ele, number| ele== number }
# ( array.my_map { |ele| ele * ele } )
#puts array.my_map(&modified_map)
# array.my_inject(0) { |ele, sum| sum += ele }
# array.multiply_els { |ele, sum| sum * ele }
