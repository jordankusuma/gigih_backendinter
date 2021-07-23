require './db/db_connector'
require_relative 'categories'

class Item
    attr_accessor :id, :name, :price, :category

    def initialize(id, name, price, category=nil)
        @id = id
        @name = name
        @price = price
        @category = category
    end

    def self.get_all_items
        client = create_db_client
        rawData = client.query("select * from items");
        items = Array.new
        rawData.each do |data|
            item = Item.new(data["id"], data["name"], data["price"])
            items.push(item)
        end
        items
    end

    def self.get_all_items_with_categories
        client = create_db_client
        rawData = client.query("select items.id, items.name, items.price, 
            categories.id as category_id, 
            categories.name as category_name
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

    def self.get_item_with_id(id)
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

    def edit_item_with_id
        return false unless valid?
        client = create_db_client
        client.query("update items set name = '#{@name}', price = #{@price} where id = #{@id}")
    
        #id_new = client.last_id()
        client.query("update item_categories set category_id = #{@category} where item_id = #{@id}")
    end

    def insert_item_with_categories
        return false unless valid?
        client = create_db_client
        client.query("insert into items (name, price) values ('#{@name}', #{@price})")
    
        id_new = client.last_id()
        client.query("insert into item_categories values (#{id_new}, #{@category})")
    end

    def delete_item_with_id
        client = create_db_client
        client.query("delete from items where id = #{@id}")
    
        client.query("delete from item_categories where item_id = #{@id}")
    end

    def valid?
        return false if @name.nil?
        return false if @price.nil?
        true
    end
end