# frozen_string_literal: true

require_relative '../main'
RSpec.describe 'Enumerable' do
  let(:test_arr) { [1, 3, 6, 9, 10] }
  let(:newArr) { [] }

  describe '#my_each' do
    context 'when input is valid' do
      it 'should display elements' do
        test_arr.my_each { |n| newArr << n }
        expect(newArr).to eql(test_arr)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when input is valid' do
      it 'should display array of index' do
        test_arr.my_each_with_index { |n, i| newArr << i }
        expect(newArr).to eql([0, 1, 2, 3, 4])
      end

      it 'should display array of elements' do
        test_arr.my_each_with_index { |n| newArr << n }
        expect(newArr).to eql(test_arr)
      end
    end
  end

  describe '#my_any? method' do
    context 'when valid input is not given' do
      it 'result should be false' do
        expect(test_arr.my_any? { |ele| ele > 20 }).to eql(false)
      end
    end

    context 'when valid input is given' do
      it 'result should be true' do
        expect(test_arr.my_any? { |ele| ele < 20 }).to eql(true)
      end
    end

    describe 'when input is empty' do
      it 'result is false' do
        expect([].my_any? { |ele| ele < 20 }).to eql(false)
      end
    end
  end

  describe '#my_none? method' do
    context 'when none empty array is given' do
      it 'should return false' do
        expect(test_arr.my_none?).to eql(false)
      end
    end
  end

  describe '#my_all? method' do
    context 'when the array do not contain false or nil' do
      it 'should give true' do
        expect(test_arr.my_all? { |n| n == false || n.nil? }).to be true
      end
    end

    context 'when at least one element is false or nil' do
      let(:arr) { [2, 3, false] }
      it 'should return false' do
        expect(arr.my_all? { |n| n == false || n.nil? }).to be false
      end
    end

    context 'when all the elements are either false or nil' do
      let(:arr) { [nil, false, false] }
      it 'should return false' do
        expect(arr.my_all? { |n| n == false || n.nil? }).to be false
      end
    end

    context 'when block is not given' do
      it 'should return true as it does not contain neither false nor nil ' do
        expect(test_arr.my_all?).to be true
      end
    end
  end

  describe '#my_count? method' do
    describe 'when block is not given' do
      context 'argument is not given'
      it 'should return total number of element' do
        expect(test_arr.my_count).to eql(5)
      end
    end

    context 'argument is given' do
      it 'should give repeatition of the number' do
        expect(test_arr.my_count(5)).to eql(0)
      end
    end

    describe 'block is given' do
      context 'when valid input is given' do
        it 'returns repetition of a particular number' do
          expect(test_arr.my_count(5) { |ele, arg| ele == arg }).to eql(0)
        end
      end
    end
  end

  describe '#my_map? method' do
    describe 'when proc is given' do
      it 'should return total number of element' do
        procs = proc { |n| n * 2 }
        expect(test_arr.my_map(&procs)).to eql([2, 6, 12, 18, 20])
      end
    end
    describe 'when proc is not given' do
      it 'should return doubled number elements' do
        expect(test_arr.my_map { |ele| ele * 2 }).to eql([2, 6, 12, 18, 20])
      end
    end
  end

  describe '#my_inject? method' do
    describe 'when initial is not  given' do
      it 'should return products of array elements' do
        expect(test_arr.my_inject { |product, ele| product * ele }).to eql(1620)
      end
    end
    describe 'when initial is not  given' do
      it 'returns sum of the elements and initial value' do
        expect(test_arr.my_inject(20) { |sum, ele| sum + ele }).to eql(49)
      end
    end
  end

  describe '#multiply_els method' do
    let(:arr2) { [1, 3, 0] }
    let(:arr3) { [1, 3, nil] }
    context 'my_inject method is implemented' do
      it 'should give product of each element' do
        expect(test_arr.multiply_els { |sum, ele| sum * ele }).to be 1620
      end
    end

    context ' when one element is zero' do
      it 'should be equal to zero' do
        expect(arr2.multiply_els { |sum, ele| sum * ele }).to be 0
      end
    end

    context ' when one element is not integer' do
      it 'should be give noMethod error' do
        expect{arr3.multiply_els { |sum, ele| sum * ele }}.to raise_error(NoMethodError)
      end
    end
  end
end
