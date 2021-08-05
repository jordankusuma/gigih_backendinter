require './models/items'
require './db/db_connector'

describe Item do
    before(:each) do
        client = create_db_client
        client.query('set foreign_key_checks = 0')
        client.query('truncate table items')
        client.query('set foreign_key_checks = 1')    
    end

    describe '#save' do
        context 'when initialized with valid input' do
            it 'should save to database' do
                item = Item.new(15, "nasi goreng", 35000)
                item.save
            end
        end
    end
    # describe '#valid?' do
    #     context 'when initialized with valid input' do
    #         it 'should return true' do
                
    #         end
    #     end
    # end
end