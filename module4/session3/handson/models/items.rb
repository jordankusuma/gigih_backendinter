require './db/db_connector'
require './models/categories'

class Item
    attr_accessor :id, :name, :price, :category

    def initialize(id, name, price, category=[])
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

    #get items id
    def self.get_item_with_id(id)
        client = create_db_client
        rawData = client.query("select * from items where id = #{id}")
        return nil unless rawData.count > 0
        data = rawData.first 
        Item.new(data["id"], data["name"], data["price"])
    end

    #get category id based on items 
    def self.get_all_categories_based_item(id)
        items = get_item_with_id(id)
        categories = Category.get_category_based_item(items)
        items.category = categories
        items
    end

    #get item info to put into item array in category class
    def self.get_item_based_category(categories)
        client = create_db_client
        rawData = client.query("select * from items join item_categories 
            on items.id = item_categories.item_id
            where item_categories.category_id = #{categories.id}
            order by items.id")
        items = Array.new
        rawData.each do |data|
            item = Item.new(data["id"], data["name"], data["price"], categories)
            items.push(item)
        end
        items
    end

    #add category into item_id
    def add_categories_into_items(category_id)
        client = create_db_client
        client.query("insert into item_categories values (#{@id}, #{category_id})")
    end

    def edit_item_with_id
        return false unless valid?
        client = create_db_client
        client.query("update items set name = '#{@name}', price = #{@price} where id = #{@id}")
    end

    # def update_categories(category_id)
    #     client = create_db_client
    #     client.query("update item_categories set category_id = '#{category_id}' where item_id = #{@id}")
    # end

    def save
        return false unless valid?
        client = create_db_client
        client.query("insert into items (id, name, price) values (#{@id}, '#{@name}', #{@price})")
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
        client.query("delete from item_categories where item_id = #{@id}")
        client.query("delete from items where id = #{@id}")
    end

    def valid?
        return false if @name.nil?
        return false if @price.nil?
        true
    end
end