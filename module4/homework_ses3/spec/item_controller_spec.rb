require './db/db_connector'
require './model/items.rb'
require './model/categories.rb'
require './controller/ItemController'

describe ItemController do  
    describe 'create item' do
        context 'when create item' do
            it 'should create item' do
                item = double()
                params = {
                    "id"=> 0,
                    "name"=> "nasi bakar",
                    "price"=> 20000,
                    "category"=>1
                }
                expect(item).to receive(:insert_item_with_categories)
                allow(Item).to receive(:new).and_return(item)
                allow(Mysql2::Client).to receive(:new).and_return(item)
                controller = ItemController.new
                controller.create_item(params)
            end
        end
    end
    describe 'create_item_form' do
        context 'when show create item' do
            it 'should show form create item' do
                controller = ItemController.new 
                allow(Category).to receive(:get_all_categories).and_return([])
                categories = Category.get_all_categories
                response = controller.create_item_form 
                expected_view = ERB.new(File.read("./views/create.erb"))
                expect(response).to eq expected_view.result(binding)
            end
        end
    end
    describe 'index' do
        context 'when show index' do
            it 'should show index' do
                controller = ItemController.new
                allow(Item).to receive(:get_all_items).and_return([])
                allow(Category).to receive(:get_all_categories).and_return([])
                result = controller.list_items_and_categories
                items = Item.get_all_items
                categories = Category.get_all_categories
                expected_view = ERB.new(File.read('./views/index.erb')).result(binding)
                expect(result).to eq(expected_view)
            end
        end
    end
    describe 'delete' do
        context 'given valid item id' do
            it 'should do delete' do
                item = double()
                params = {
                    "id"=> 1
                }
                expect(item).to receive(:delete_item_with_id)
                allow(Item).to receive(:get_all_categories_based_item).with(params).and_return(item)
                allow(Mysql2::Client).to receive(:new).and_return(item)
                controller = ItemController.new 
                controller.delete({"id"=> params})
            end
        end
    end
    describe 'edit_item' do
        context "given valid parameter" do
            it "should return true" do
                item = double()
                params = {
                    "id"=> 1,
                    "name"=> "nasi bakar",
                    "price"=> 20000,
                    "category"=>1
                }
                expect(item).to receive(:edit_item_with_id)
                allow(Item).to receive(:new).and_return(item)
                allow(Mysql2::Client).to receive(:new).and_return(item)
                controller = ItemController.new
                controller.edit_item(params)
            end
        end
    end
    describe 'edit_item_form' do
        it 'should show edit item form' do
            item = double()
            params = {
                "id"=> 1,
                "name"=> "nasi bakar",
                "price"=> 20000,
                "category"=> 1
            } 
            expect(item).to receive(:get_all_categories_based_item).with({id: 1})
            allow(Category).to receive(:get_all_categories).and_return([])
            allow(Item).to receive(:new).and_return(item)
            controller = ItemController.new
            response = controller.edit_item_form({id: 1})
            expected_view = ERB.new(File.read("./views/edit.erb"))
            expect(response).to eq expected_view.result(binding)
        end
    end
end
