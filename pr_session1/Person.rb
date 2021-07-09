class Person
    attr_reader :name, :attack, :posisi, :random
    attr_accessor :hitpoint

    def initialize(name, attack, hitpoint, posisi)
        @name = name
        @attack = attack
        @hitpoint = hitpoint
        @posisi = posisi
        @random = 0
    end

    def to_s
        puts "#{@name} has #{@hitpoint} hitpoint and #{@attack} attack damage"
    end

    def status(other_person)
        puts "#{@name} has attacked #{other_person.name} with #{@attack} attack damage"
    end

    def attack(other_person)
        other_person.take_damage(@attack)
        # puts (other_person.random)
        # puts (other_person.posisi)
        # puts (other_person.name)
        status(other_person)
        other_person.deflects()
    end

    def take_damage(damage)
        @random = rand()
        if (@posisi == "hero" && @random >= 0.8)
          @hitpoint -= damage
        end
        if (@posisi == "enemy")
          @hitpoint -= damage
        end
    end

    def deflects()
        if (@random < 0.8 && @posisi == "hero")
          puts "#{@name} deflects the attack"
        end
    end

    def cek
        if (@hitpoint <= 0)
          puts "#{@name} died"
          true
        end
    end
end
