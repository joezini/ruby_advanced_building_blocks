require 'spec_helper.rb'

describe '#my_each' do
	it "yields to a passed block" do 
		expect{ |b| [1,2].my_each(&b) }.to yield_successive_args(1, 2)
	end

	it "yields the same number of times as there are items in the array" do
		array10 = [0,1,2,3,4,5,6,7,8,9]
		expect{ |b| array10.my_each(&b) }.to yield_control.exactly(10).times
	end

	it "doubles each number in an array" do
		result = []
		[1,2,3.5,10].my_each { |e| result << 2 * e }
		expect(result).to eql([2,4,7.0,20])
	end

	it "raises a LocalJumpError if no block passed" do
		expect{ [1,2].my_each }.to raise_error(LocalJumpError)
	end
end
