require_relative '../src/wli' 

RSpec.describe WLI do
    it 'has 0 likes' do
        #given
        wli = WLI.new

        #then
        expect(wli.likes).to eq("no one like this")
    end
    it 'has 1 like' do
        #given
        wli = WLI.new

        wli.names = ["Peter"]

        #then
        expect(wli.likes).to eq("Peter like this")
    end
    it 'has 2 likes' do
        #given
        wli = WLI.new

        #when
        wli.names = ["Jacob", "Alex"] 

        #then
        expect(wli.likes).to eq("Jacob and Alex like this")
    end
    it 'has 3 likes' do
        #given
        wli = WLI.new

        #when
        wli.names = ["Max", "John", "Mark"] 

        #then
        expect(wli.likes).to eq("Max, John and Mark like this")
    end
    it 'has 4 likes' do
        #given
        wli = WLI.new

        #when
        wli.names = ["Alex", "Jacob", "Mark", "Max"] 

        #then
        expect(wli.likes).to eq("Alex, Jacob and 2 others like this")
    end
    it 'has 5 likes' do
        #given
        wli = WLI.new

        #when
        wli.names = ["Alex", "Jacob", "Mark", "Max", "Kevin"] 

        #then
        expect(wli.likes).to eq("Alex, Jacob and 3 others like this")
    end
end