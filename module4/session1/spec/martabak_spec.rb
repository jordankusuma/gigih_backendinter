require_relative '../src/martabak' 

RSpec.describe Martabak do
    it 'is delicious' do
        #given
        martabak = Martabak.new("cokelat")

        #when
        taste = martabak.taste 

        #then
        expect(taste).to eq("martabak cokelat is delicious")
    end
end