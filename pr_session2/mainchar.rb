require_relative 'hero'

class Mainchar < Hero
  def initialize(name, hitpoint, attack)
      super(name, hitpoint, attack)
      @healpoint = 20
  end

  def attack(other_person)
      super(other_person)
  end

  def restore(other_person)
      other_person.heal(@healpoint)
      puts "#{@name} heals #{other_person.name}, restoring #{@healpoint} hitpoints"
  end
end
