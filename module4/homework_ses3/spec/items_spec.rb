require './db/db_connector'
require './model/items.rb'

describe Item do
    describe 'update' do
        context 'when do update' do
            it 'should change data' do
                stub_client = double()
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                category = Category.new(1, "main_dish")
                item = Item.new(5, "Nasi Bakar", 20000, category)
                query1 = "UPDATE item_categories SET category_id=#{category} WHERE item_id = #{item.id}"
                query2 = "update items set name = '#{item.name}', price = #{item.price} where id = #{item.id}"
                expect(stub_client).to receive(:query).with(query1)
                expect(stub_client).to receive(:query).with(query2)
                item.edit_item_with_id
            end
        end
    end
    describe 'delete' do
        context 'when do delete' do
            it 'should delete data' do
                stub_client = double()
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                category = Category.new(1, "main_dish")
                item = Item.new(5, "Nasi Bakar", 20000, category)
                query1 = "delete from item_categories where item_id = #{item.id}"
                query2 = "delete from items where id = #{item.id}"
                expect(stub_client).to receive(:query).with(query1)
                expect(stub_client).to receive(:query).with(query2)
                item.delete_item_with_id
            end
        end
    end
    describe 'insert' do
        context 'when do insert' do
            it 'should insert item with categories' do
                stub_client = double()
                category = Category.new(1, "main_dish")
                item = Item.new(6, "Nasi Bakar", 20000, category)
                query1 = "insert into items (name, price) values ('#{item.name}', #{item.price})"
                query2 = "insert into item_categories values (#{item.id}, #{category})"
                expect(stub_client).to receive(:query).with(query1)
                expect(stub_client).to receive(:query).with(query2)
                allow(stub_client).to receive(:last_id).and_return(item.id)
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(item.insert_item_with_categories).to eq(true)
            end
        end
    end
    describe 'get all items' do
        context 'when get items' do
            it 'should get all items' do
                stub_client = double()
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                query = "select * from items"
                items = [
                    {"id": 1, "name": "Nasi Goreng", "price": 35000},
                    {"id": 2, "name": "Nasi Bakar", "price": 15000}
                ]
                expect(stub_client).to receive(:query).with(query).and_return(items)
                getItem = Item.get_all_items
                expect(getItem).not_to be_nil
            end
        end
    end
    describe 'get item with id' do
        context 'when get item' do
            it 'should get item based id' do
                stub_client = double()
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                item = double()
                allow(item).to receive(:id).and_return(1)
                query = "select * from items where id = #{item.id}"
                items = [
                    {"id": 1, "name": "Nasi Bakar", "price": 20000}
                ]
                expect(stub_client).to receive(:query).with(query).and_return(items)
                getItem = Item.get_item_with_id(item.id)
                expect(getItem).not_to be_nil
            end
        end
        context 'when data not found' do
            it 'should return empty' do
                stub_client = double
                query = "select * from items where id = 1"
                allow(Mysql2::Client).to receive(:new).and_return(stub_client)
                expect(stub_client).to receive(:query).with(query).and_return([])
                foundItem = Item.get_item_with_id(1)
                expect(foundItem).to eq(nil)
            end
        end
    end 
    describe 'get_item_based_category' do
        it 'should return item based category' do
            stub_client = double()
            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            query = "select * from items join item_categories on items.id = item_categories.item_id where item_categories.category_id = 1 order by items.id"
            items = [
                {"id": 1, "name": "Nasi Bakar", "price": 20000, "category_id": 1, "category_name": "main_dish"}
            ]
            expect(stub_client).to receive(:query).with(query).and_return(items)
            category = Category.new(1, "main_dish")
            getItem = Item.get_item_based_category(category)
            expect(getItem).not_to be_nil
        end
    end
    describe 'add_categories_into_items' do
        it 'should add category into items' do
            stub_client = double()
            allow(Mysql2::Client).to receive(:new).and_return(stub_client)

            category = Category.new(1, "main_dish")
            item = Item.new(6, "Nasi Bakar", 20000, category)
            query = "insert into item_categories values (#{item.id}, #{category.id})"
            expect(stub_client).to receive(:query).with(query)

            item.add_categories_into_items(category.id)
        end
    end
    describe 'valid?' do
        context 'data is valid' do
            it 'returns true if data is valid' do
                item = Item.new(1, "Nasi Bakar", 20000, 1)
                expect(item.valid?).to eq(true)
            end
        end
        context 'name is missing' do
            it 'returns false if name is missing' do
                item = Item.new(1, nil, 20000, 1)
                expect(item.valid?).to eq(false)
            end
        end
        context 'price is missing' do
            it 'returns false if price is missing' do
                item = Item.new(1, "Nasi Bakar", nil, 1)
                expect(item.valid?).to eq(false)
            end
        end
    end
end