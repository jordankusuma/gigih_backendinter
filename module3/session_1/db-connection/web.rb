require 'sinatra'
require_relative './db_connector'

get '/' do 
    items = get_all_items
    erb :index, locals: {
        items: items
    }
end

get '/items/:id/show' do 
    id = params['id']
    items = get_item_with_id(id)
    erb :show, locals: {
        items: items
    }
end

get '/items/:id/edit' do 
    id = params['id']
    items = get_item_with_id(id)
    categories = get_all_categories
    erb :edit, locals: {
        items: items,
        categories: categories
    }
end

post '/items/:id/edit/' do
    id = params["id"]
    name = params["name"]
    price = params["price"]
    categories = params["pick_category"]
    edit_item_with_id(id, name, price, categories)
    redirect('/')
end

get '/items/:id/delete' do 
    id = params['id']
    delete_item_with_id(id)
    redirect('/')
end

get '/items/new' do
    categories = get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/create' do
    name = params["name"]
    price = params["price"]
    categories = params["pick_category"]
    insert_item_with_categories(name, price, categories)
    redirect('/')
end