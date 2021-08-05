require 'sinatra'
require './controller/ItemController'

get '/' do
    controller = ItemController.new 
    controller.list_items_and_categories
end

get '/items/new' do
    controller = ItemController.new 
    controller.create_item_form
end

post '/items/new' do
    controller = ItemController.new 
    controller.create_item(params)
    redirect '/'
end

get '/items/:id/delete' do 
    controller = ItemController.new 
    controller.delete(params)
    redirect '/'
end

get '/items/:id/show' do 
    controller = ItemController.new
    controller.show(params)
end

get '/items/:id/edit' do
    controller = ItemController.new
    controller.edit_item_form(params)
end

post '/items/:id/edit/' do
    controller = ItemController.new
    controller.edit_item(params)
    redirect '/'
end

#list category into items
get '/items/:id/categories' do
    controller = ItemController.new 
    controller.show_category_based_item(params)
end

#create category into items
post '/items/:id/categories' do
    controller = ItemController.new 
    controller.add_category_into_items(params)
end

# create category
get '/categories/new' do
    controller = ItemController.new 
    controller.create_category_form
end

post '/categories/new' do
    controller = ItemController.new 
    controller.add_category(params)
    redirect '/'
end

#list item belongs to category
get '/categories/:id/items' do
    controller = ItemController.new 
    controller.show_item_based_category(params)
end

#delete category in index
get '/categories/:id/delete' do
    controller = ItemController.new 
    controller.delete_category(params)
    redirect '/'
end

#edit category 
get '/categories/:id/edit' do
    controller = ItemController.new 
    controller.edit_categories_form(params)
end

post '/categories/:id/edit' do
    controller = ItemController.new 
    controller.edit_category(params)
    redirect '/'
end







