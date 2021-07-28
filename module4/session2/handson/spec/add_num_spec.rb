require_relative '../src/add_num.rb'

RSpec.describe AddNum do
    it "returns [1] when input is [0]" do
        add_number = AddNum.new

        result = add_number.add([0])

        expect(result).to eq([1])
    end
    it "returns [5, 6, 2] when input [5, 6, 1]" do
        add_number = AddNum.new 

        result = add_number.add([5, 6, 1])

        expect(result).to eq([5, 6, 2])
    end
    it "returns [5, 6, 0, 0] when input [5, 5, 9, 9]" do
        add_number = AddNum.new 

        result = add_number.add([5, 5, 9, 9])

        expect(result).to eq([5, 6, 0, 0])
    end
end