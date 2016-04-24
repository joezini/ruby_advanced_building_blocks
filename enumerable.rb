module Enumerable
	def my_each
		self.to_a.length.times do |i|
			yield(self.to_a[i])
		end
	end

	def my_each_with_index
		self.length.times do |i|
			yield(self[i], i)
		end
	end

	def my_select
		result = []
		self.my_each do |x|
			result << x if yield(x)
		end
		result
	end

	def my_all?
		self.my_each do |x|
			return false if !yield(x)
		end
		true
	end

	def my_any?
		self.my_each do |x|
			return true if yield(x)
		end
		false
	end

	def my_none?
		self.my_each do |x|
			return false if yield(x)
		end
		true
	end

	def my_count(*args, &block)
		if !block_given? && args.size == 0
			return self.length
		elsif !block_given? && args.size == 1
			return self.my_select{|x| x == args[0]}.length
		elsif block_given?
			return self.my_select(&block).length
		end
	end

	def my_map(*args)
		result = []
		if block_given?
			self.my_each do |x|
				result << yield(x)
			end
		elsif args.length > 0
			self.my_each do |x|
				result << args[0].call(x)
			end
		end
		result
	end

	def my_map_proc(&proc)
		result = []
		self.my_each do |x|
			result << proc.call(x)
		end
		result
	end

	def my_inject
		accumulator = self.to_a[0]
		1.upto(self.size-1) do |i|
			accumulator = yield(accumulator, self.to_a[i])
		end
		accumulator
	end

	def multiply_els
		self.my_inject{|acc, x| x * acc} 
	end
end

puts "--my_each test"
[1,2,3,4,5].my_each{|x| puts x}

puts "--my_each_with_index test"
["apples", "bananas", "canteloupes", "durians", "eddoes"].my_each_with_index{|x, i| puts "At position #{i} is #{x}"}

puts "--my_select test"
p [1,2,3,4,5,6,7,8].my_select{|x| x%2 == 0}

puts "--my_all? test"
if [2,4,6,8].my_all?{|x| x%2==0}
	puts "true for all evens being even"
end
unless [1,2,4,6].my_all?{|x| x%2==0}
	puts "false when one odd number"
end

puts "--my_any? test"
if [1,3,5,6].my_any?{|x| x%2 == 0}
	puts "true when an even present"
end
unless [1,3,5,7].my_any?{|x| x%2 == 0}
	puts "false when no evens"
end

puts "--my_none? test"
unless [1,3,5,6].my_none?{|x| x%2 == 0}
	puts "false when an even present"
end
if [1,3,5,7].my_none?{|x| x%2 == 0}
	puts "true when no evens"
end

puts "--my_count test"
puts "counted 3 elements" if {a: 1, b: 2, c: 3}.my_count == 3
if [1,2,3,2,3,4,2,5].my_count(2) == 3
	puts "counted 3 2's"
end
if [1,2,3,4,5,6,7,8].my_count{|x| x%2 != 0} == 4
	puts "counted 4 odd numbers"
end

puts "--my_map test"
p [1,2,3,4].my_map{|x| x**2}

puts "--my_inject test"
p (5..10).my_inject {|sum, n| sum + n} 

puts "--multiply_els test"
p [2,4,5].multiply_els

puts "--my_map_proc test"
test_proc = Proc.new {|x| 2*x}
p [4,6,8].my_map_proc(&test_proc)

puts "--my_map with proc support test"
test_proc_2 = Proc.new {|x| 3*x}
p [4,6,8].my_map(&test_proc_2)
#p [4,6,8].my_map(&test_proc_2){|x| 2*x}
