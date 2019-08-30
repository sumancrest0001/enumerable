module Enumerable
  def my_each
    for i in (0...self.size)
      yield(self[i])
    end
  end
  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i)
    end
  end

  def my_select
    output = []
    self.my_each {|ele| odd_numbers << ele if yield(ele)}
    output
  end

  def my_all?
    output = true
    self.my_each do |ele|
       if yield(ele) != true
         output = false
       end
     end
    output
  end

  def my_any?
    output = false
    self.my_each do |ele|
       if yield(ele) == true
         output = true
       end
     end
    output
  end

  def my_none?
    output = true
    self.my_each do |ele|
       if yield(ele) != false
         output = false
       end
     end
    puts output
  end

end

array = [1, 3, 24, 6, 37, 2, 29, 10, 1]
#array.my_each {|i| puts "doubled number is: #{i * 2}"}
#array.my_each_with_index {|number, i| puts "index is #{i} and element is #{number}"}
#array.my_select {|ele| ele.odd?}
#array.my_all? {|ele| ele >= 2}
#array.my_any? {|ele| ele >= 20}
array.my_none? {|ele| ele < 1}
