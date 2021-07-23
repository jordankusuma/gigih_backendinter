require 'sinatra'
require './model/items'

get '/' do
    items = Item.get_all_items_with_categories
    erb :index, locals: {
        items: items
    }
end

get '/items/new' do
    categories = Category.get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/create' do
    new_item = Item.new(0, params["name"], params["price"], params["pick_category"])
    new_item.insert_item_with_categories
    redirect('/')
end

get '/items/:id/delete' do 
    items = Item.get_item_with_id(params['id'])
    items.each do |item|   
        new_items = Item.new(item.id, item.name, item.price)
        new_items.delete_item_with_id
    end 
    redirect('/')
end

get '/items/:id/show' do 
    items = Item.get_item_with_id(params['id'])
    erb :show, locals: {
        items: items
    }
end

get '/items/:id/edit' do
    items = Item.get_item_with_id(params['id'])
    categories = Category.get_all_categories
    erb :edit, locals: {
        items: items,
        categories: categories
    }
end

post '/items/:id/edit/' do
    items = Item.new(params['id'], params['name'], params['price'], params["pick_category"])
    items.edit_item_with_id
    redirect('/')
end

