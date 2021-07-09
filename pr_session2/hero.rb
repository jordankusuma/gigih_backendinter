require_relative 'person'

class Hero < Person
  def initialize(name, hitpoint, attack)
      super(name, hitpoint, attack)
      @full_hitpoint = hitpoint
  end

  def take_damage(damage)
    if(deflects())
      puts "#{@name} deflects the attack"
    else
      @hitpoint -= damage
    end
    #puts @dodge
  end

  def attack(other_person)
    super(other_person)
    if (other_person.die? == false)
      if (other_person.flee? == true)
        other_person.statusflee
      end
    end
  end

  def heal(healpoint)
      if (@hitpoint < @full_hitpoint)
        if (@hitpoint + healpoint > @full_hitpoint)
          @hitpoint = @full_hitpoint
        else
          @hitpoint += healpoint
        end
      end
  end
end
