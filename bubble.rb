def bubble_sort(input)
	output = input
	(input.length - 1).times do |i|  #0..6
		for j in (0..(input.length - 2 - i)) do    #0..6, #0..5 
			if output[j] > output[j+1]
				output[j], output[j+1] = output[j+1], output[j]
			end
		end
	end
	p output
end

bubble_sort([5,7,2,4,1,8,3,6])

def bubble_sort_by(input)
	output = input
	(input.length - 1).times do |i|  #0..6
		for j in (0..(input.length - 2 - i)) do    #0..6, #0..5 
			if yield(output[j], output[j+1]) > 1
				output[j], output[j+1] = output[j+1], output[j]
			end
		end
	end
	p output
end

bubble_sort_by([[1,2,3,4,5,6,7],[1,2,3],[1,2,3,4,5]]) do |left,right|
	left.length - right.length
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
end