require 'mysql2'
require_relative './item'
require_relative './category'

def create_db_client
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "jordan",
        :database => "food_oms_db"
    )
    client
end

def get_all_items
    client = create_db_client
    rawData = client.query("select * from items");
    items = Array.new
    rawData.each do |data|
        item = Item.new(data["id"], data["name"], data["price"])
        items.push(item)
    end
    items
end

def get_all_categories
    client = create_db_client
    rawData = client.query("select * from categories");
    categories = Array.new
    rawData.each do |data|
        category = Category.new(data["id"], data["name"])
        categories.push(category)
    end
    categories
end

def get_item_with_id(id)
    client = create_db_client
    rawData = client.query("select items.id, items.name, items.price, categories.id as category_id, categories.name as category_name
    from items 
    left join item_categories on items.id = item_categories.item_id
    left join categories on item_categories.category_id = categories.id
    where items.id = '#{id}'")
    items = Array.new
    rawData.each do |data|
        category = Category.new(data["category_id"], data["category_name"])
        item = Item.new(data["id"], data["name"], data["price"], category)
        items.push(item)
    end
    items
end

def delete_item_with_id(id)
    client = create_db_client
    client.query("delete from items where id = #{id}")

    client.query("delete from item_categories where item_id = #{id}")
end

def get_all_items_with_categories
    client = create_db_client
    rawData = client.query("select items.id, items.name, items.price, categories.id as category_id, categories.name as category_name
        from items 
        left join item_categories on items.id = item_categories.item_id
        left join categories on item_categories.category_id = categories.id")
    items = Array.new
    rawData.each do |data|
        category = Category.new(data["category_id"], data["category_name"])
        item = Item.new(data["id"], data["name"], data["price"], category)
        items.push(item)
    end
    items
end

def insert_item(name, price)
    client = create_db_client
    client.query("insert into items (name, price) values ('#{name}', #{price})")
end

def insert_item_with_categories(name, price, categories)
    client = create_db_client
    client.query("insert into items (name, price) values ('#{name}', #{price})")

    id_new = client.last_id()
    client.query("insert into item_categories values (#{id_new}, #{categories})")
end

def edit_item_with_id(id, name, price, categories)
    client = create_db_client
    client.query("update items set name = '#{name}', price = #{price} where id = #{id}")

    #id_new = client.last_id()
    client.query("update item_categories set category_id = #{categories} where item_id = #{id}")
end

#puts(get_all_items.each)
#puts(get_all_categories.each)
#puts(get_category("Spagethi").each)