class AddNum
    def add(input)
        if (input == [0])
            input = [1]
        else
            last_index = input.length() - 1
            input.reverse_each do |num|
                input[last_index] = num + 1
                break
            end
        end
        input
    end
    
end