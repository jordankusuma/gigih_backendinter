class AddNum
    def add(input)
        if (input == [0])
            input = [1]
        else
            input[0] += 1
        end
        input
    end
    
end