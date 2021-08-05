class WLI
    attr_accessor :names
    def initialize

    end

    def likes
        sentence = ""
        unless @names.nil?
            if (@names.length == 1)
                sentence = "#{@names[0]} like this"
            elsif (@names.length > 1)
                @names.each_with_index do |name, index|
                    if (@names.length > 1 && @names.length <= 3)
                        if (index == @names.length - 1)
                            sentence += "and #{name} like this"
                        elsif (index < @names.length - 2)
                            sentence += "#{name}, "
                        else
                            sentence += "#{name} "
                        end
                    else
                        if (index == 0)
                            sentence += "#{name}, "
                        elsif (index == 1)
                            sentence += "#{name} "
                        else
                            sentence += "and #{@names.length - index} others like this"
                            break
                        end
                    end
                end
            end
        end
        if sentence == ""
            sentence = "no one like this"
        end
        sentence
    end
end