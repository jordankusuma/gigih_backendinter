require './db/db_connector'

class Category
    attr_accessor :id, :name, :items

    def initialize(id, name, items=[])
        @id = id
        @name = name
        @items = items
    end

    def self.get_all_categories
        client = create_db_client
        rawData = client.query("select * from categories");
        categories = Array.new
        rawData.each do |data|
            category = Category.new(data["id"], data["name"])
            categories.push(category)
        end
        categories
    end

    def self.get_category_based_item(id)
        client = create_db_client
        rawData = client.query("select * from categories where id = #{id}")
        categories = Array.new
        rawData.each do |data|
            category = Category.new(data["id"], data["name"])
            categories.push(category)
        end
        categories
    end

    def save
        client = create_db_client
        client.query("insert into categories values(#{@id}, '#{@name}')")
    end

    def self.get_category_with_id(id)
        client = create_db_client
        rawData = client.query("select * from categories where id = #{id}")
        return nil unless rawData.count > 0
        data = rawData.first 
        Category.new(data["id"], data["name"])
    end

    #get category info to put into category array in item class
    def self.get_category_based_item(items)
        client = create_db_client
        rawData = client.query("select * from categories join item_categories 
            on categories.id = item_categories.category_id
            where item_categories.item_id = #{items.id}
            order by categories.id")
        categories = Array.new
        rawData.each do |data|
            category = Category.new(data["id"], data["name"], items)
            categories.push(category)
        end
        categories
    end

    #get items id based on categories
    def self.get_all_item_based_category(id)
        categories = get_category_with_id(id)
        items = Item.get_item_based_category(categories)
        categories.items = items
        categories
    end 

    def delete_category(id) 
        client = create_db_client
        client.query("delete from item_categories where category_id = #{id}")
        client.query("delete from categories where id = #{id}")
    end

    def update(name)
        client = create_db_client
        client.query("update categories set name = '#{name}' where id = #{@id}")
    end
end