require_relative '../src/add_num.rb'

RSpec.describe AddNum do
    it "returns [1] when input is [0]" do
        add_number = AddNum.new

        result = add_number.add([0])

        expect(result).to eq([1])
    end
    it "returns [5] when input is [4]" do
        add_number = AddNum.new

        result = add_number.add([4])

        expect(result).to eq([5])
    end
    it "returns [1, 7] when input is [1, 6]" do
        add_number = AddNum.new

        result = add_number.add([1, 6])

        expect(result).to eq([1, 7])
    end
    it "returns [4, 4, 0] when input is [4, 3, 9]" do
        add_number = AddNum.new

        result = add_number.add([2, 9])

        expect(result).to eq([3, 0])
    end
    it "returns [3, 0] when input is [2, 9]" do
        add_number = AddNum.new

        result = add_number.add([2, 9])

        expect(result).to eq([3, 0])
    end
end