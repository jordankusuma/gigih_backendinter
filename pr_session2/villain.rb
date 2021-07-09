require_relative "person"

class Villain < Person
  def initialize(name, hitpoint, attack)
      super(name, hitpoint, attack)
      @flee_percentage = 0.5
      @fled = false
  end

  #broken
  def take_damage(damage)
      @hitpoint -= damage
      #puts @hitpoint
      if @hitpoint <= 50
        flee if rand < @flee_percentage
      end
  end

  def flee
      @fled = true
  end

  def flee?
      @fled
  end

  def statusflee
      puts "#{@name} has fled the battlefield with #{@hitpoint} hitpoint left"
  end
end
