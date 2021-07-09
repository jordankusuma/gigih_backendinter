require_relative 'villain'

class MongolArcher < Villain
  def attack(other_person)
    puts "#{@name} shoots an arrow at #{other_person.name} with #{@attack} damage"
    other_person.take_damage(@attack)
  end
end

class MongolSpearman < Villain
  def attack(other_person)
    puts "#{@name} thrusts #{other_person.name} with #{@attack} damage"
    other_person.take_damage(@attack)
  end
end

class MongolSwordman < Villain
  def attack(other_person)
    puts "#{@name} slashes #{other_person.name} with #{@attack} damage"
    other_person.take_damage(@attack)
  end
end
