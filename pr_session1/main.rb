require_relative 'Person'

jin = Person.new("Jin Sakai", 50, 100, "hero")
puts jin
puts "\n"

khotun = Person.new("Khotun Khan", 50, 500, "enemy")
puts khotun
puts "\n"

loop do
  jin.attack(khotun)
  puts khotun
  puts "\n"
  break if khotun.cek

  khotun.attack(jin)
  puts jin
  puts "\n"
  break if jin.cek
end
