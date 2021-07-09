class Person
  attr_reader :name, :attack, :dodge
  attr_accessor :hitpoint

  def initialize(name, hitpoint, attack)
      @name = name
      @hitpoint = hitpoint
      @attack = attack
      @dodge = 0
  end

  def to_s
      puts "#{@name} has #{@hitpoint} hitpoint and #{@attack} attack damage"
  end

  def status(other_person)
      puts "#{@name} has attacked #{other_person.name} with #{@attack} attack damage"
  end

  def attack(other_person)
      other_person.take_damage(@attack)
      status(other_person)
  end

  def take_damage(damage)
      @hitpoint -= damage
  end

  def deflects()
      @dodge = rand()
      if (@dodge <= 0.5)
        true
      else
        false
      end
  end

  def die?
    if (@hitpoint <= 0)
      true
    else
      false
    end
  end

  def cek
      if (die?)
        puts "#{@name} died"
        true
      end
  end
end
