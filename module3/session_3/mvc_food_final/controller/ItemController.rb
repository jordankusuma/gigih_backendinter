require './model/items'
require './model/categories'

class ItemController
    #items
    def create_item(params)
        items = Item.new(0, params["name"], params["price"], params["pick_category"])
        items.insert_item_with_categories
        list_items_and_categories
    end
    
    def create_item_form
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/create.erb"))
        renderer.result(binding)
    end

    def edit_item_form(params)
        items = Item.get_all_categories_based_item(params['id'])
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
    end

    def edit_item(params)
        items = Item.new(params['id'], params['name'], params['price'])
        items.edit_item_with_id
        list_items_and_categories
    end

    def delete(params)
        items = Item.get_all_categories_based_item(params['id'])
        items.delete_item_with_id
        list_items_and_categories
    end

    def show(params)
        items = Item.get_all_categories_based_item(params['id'])
        renderer = ERB.new(File.read("./views/show.erb"))
        renderer.result(binding)
    end

    #categories
    def list_items_and_categories
        items = Item.get_all_items
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end

    def show_category_based_item(params)
        items = Item.get_all_categories_based_item(params['id'])
        categories = Category.get_all_categories
        renderer = ERB.new(File.read("./views/show_categories.erb"))
        renderer.result(binding)
    end
    ##

    def add_category_into_items(params)
        items = Item.get_item_with_id(params['id'])
        items.add_categories_into_items(params["pick_category"])
        show_category_based_item(params)
    end
    ## 

    #create category
    def create_category_form
        renderer = ERB.new(File.read("./views/create_categories.erb"))
        renderer.result(binding)
    end

    def add_category(params)
        new_category = Category.new(0, params['name'])
        new_category.save
        list_items_and_categories
    end
    ##

    def show_item_based_category(params)
        categories = Category.get_all_item_based_category(params['id'])
        renderer = ERB.new(File.read("./views/show_items.erb"))
        renderer.result(binding)
    end

    def delete_category(params)
        category = Category.get_category_with_id(params['id'])
        category.delete_category(category.id)
        list_items_and_categories
    end

    def edit_categories_form(params)
        category = Category.get_category_with_id(params['id'])
        renderer = ERB.new(File.read("./views/edit_categories.erb"))
        renderer.result(binding)
    end

    def edit_category(params)
        category = Category.get_category_with_id(params['pick_id'])
        category.update(params['pick_category'])
        list_items_and_categories
    end
end