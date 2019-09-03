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
    my_each { |ele| output = false if yield(ele) != true } if block_given?
    my_each { |ele| output = false if ele == nil || ele == false} if !block_given?
    output
  end

  def my_any?
    output = false
    my_each do |ele|
      output = true if yield(ele) == true
    end
    output
  end

  def my_none?(arg = nil)
    output = true
    if  block_given?
      my_each { |ele| output = false if yield(ele, arg) == true }
    elsif !block_given?
      my_each { |ele| output = false if ele == arg } if !arg.nil?
      my_each { |ele| output = false if ! ele ==false || ! ele == nil  } if arg.nil?
    end
    output
  end

  def my_count(number = nil)
    count = 0
    if block_given?
      my_each { |ele| count += 1 if yield(ele, number) == true }
    elsif number.nil?
      my_each { count += 1 }
    else
      my_each { |ele| count += 1 if ele == number }
    end
    count
  end

  def my_map(&procs)
    output = []
    my_each { |ele| output << (procs.nil? ? yield(ele) : procs.call(ele)) }
    output
  end

  def my_inject(memo = nil, sym = nil)
    return my_inject(nil, memo) if memo.is_a? Symbol
    return my_inject(memo) { |mem, e| :+.to_proc.call(mem, e) } unless sym.nil?
    my_each { |e| memo = memo.nil? ? first : yield(memo, e) }
    memo
  end

  def multiply_els
    my_inject { |ele, sum| sum * ele }
  end
end
