class AddNum
    def add(input)
        if (input == [0])
            input = [1]
        else
            last_index = input.length() - 1
            input.reverse_each do |num|
                if (!more_than_one_digit?(num))
                    input[last_index] = num + 1
                    break
                end
            end
        end
        input
    end
    def more_than_one_digit?(input)
        input >= 9
    end
end