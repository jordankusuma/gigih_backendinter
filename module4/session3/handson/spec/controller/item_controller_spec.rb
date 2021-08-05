require './controller/item_controller'

describe ItemController do
    describe '#add_category' do
        context 'given valid input' do
            before(:each) do
                controller = ItemController.new
                params = {
                    'id' => 20,
                    'name' => 'Nasi Bakar',
                }
                #params = Category.new(20, 'Nasi Bakar', 20000)
                @response = controller.add_category(params)
            end
        
            it 'should save category' do
                expected_category = Category.get_category_with_id(20)
                expect(expected_category).not_to be_nil
            end

            it 'render category' do
                expected_view = ERB.new(File.read("./views/category.erb")).result_with_hash(
                    categories: Category.new(20, "Nasi Bakar")
                )
                expect(@response).to eq(expected_view)
            end
        end
    end
    
    describe '#create_category_form' do
        it 'should show create form' do
            controller = ItemController.new 
            response = controller.create_category_form 
            expected_view = ERB.new(File.read("./views/create_categories.erb"))
            expect(response).to eq(expected_view.result)
        end
    end

end