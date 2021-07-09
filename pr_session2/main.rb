require_relative 'villain'
require_relative 'person'
require_relative 'hero'
require_relative 'mainchar'
require_relative 'mongol'

jin = Mainchar.new("Jin Sakai", 100, 50)
yuna = Hero.new("Yuna", 90, 45)
ishikawa = Hero.new("Sensei ishikawa", 80, 60)
archer = MongolArcher.new("Mongol Archer", 80, 100)
spear = MongolSpearman.new("Mongol Spearman", 120, 100)
sword = MongolSwordman.new("Mongol Swordman", 100, 100)

villains = [archer, spear, sword]
heroes = [jin, yuna, ishikawa]

i = 1
until (jin.die? || heroes.size == 0 || villains.size == 0)
  puts "=============== Turn #{i} ======================="
  puts "\n"

  heroes.each do |hero|
    puts hero
  end
  puts "\n"
  villains.each do |villain|
    puts villain
  end
  puts "\n"

  #jin make choice

  puts "As Jin Sakai, what do you want to do this turn"
  puts "1) Attack an enemy"
  puts "2) Heal an ally"

  number = gets.chomp.to_i()

  while (nomor != 1 && nomor != 2)
    puts "please choose correctly"
    nomor = gets.chomp.to_i()
  end

  #jin attack enemy
  if (number == 1)
    puts "[if you pick 1]"
    puts "which enemy you want to attack?"
    count = 1
    villains.each do |villain|
      puts "#{count}) #{villain.name}"
      count += 1
    end

    nomor = gets.chomp.to_i()

    while (nomor != 1 && nomor != 2 && nomor != 3)
      puts "please choose correctly"
      nomor = gets.chomp.to_i()
    end

    nomor -= 1

    #jin attack and check if villain die / flee
    if (villains.size != 0)
      jin.attack(villains[nomor])
      villains.each_with_index do |villain, index|
        villains.delete(villain) if villain.cek || villain.flee?
      end

      # villains.each_with_index do |villain, index|
      #   puts index
      #   puts villain.name
      # end
    end

  elsif (number == 2)
    puts "[if you pick 2]"
    puts "which ally you want to heal?"
    count = 1
    heroes.each do |hero|
      if (hero.name != "Jin Sakai")
        puts "#{count}) #{hero.name}"
        count += 1
      end
    end

    nomor = gets.chomp.to_i()

    #jin attack and check if villain die / flee
    jin.restore(heroes[nomor])
  end

  #heroes attack enemy
  heroes.each do |hero|
    if (hero.name != "Jin Sakai")
      if (villains.size != 0)
        nomor = rand(villains.size)
        hero.attack(villains[nomor])

        villains.each_with_index do |villain, index|
          villains.delete(villain) if villain.cek || villain.flee?
        end

        # villains.each_with_index do |villain, index|
        #   puts index
        #   puts villain.name
        # end
      end
    end
  end

  puts "\n"

  #enemy attack heroes
  if (heroes.size != 0)
    villains.each do |villain|
      villain.attack(heroes[rand(heroes.size)])

      heroes.each do |hero|
        heroes.delete(hero) if hero.cek
      end

      # heroes.each_with_index do |hero, index|
      #   puts index
      #   puts hero.name
      # end
    end
  end

  i += 1
end

if (villains.size == 0)
  puts "Heroes wins"
else
  puts "Enemies wins"
end
