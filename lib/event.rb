class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory.include?(item)
    end
  end

  def items_list
    @food_trucks.flat_map do |food_truck|
      food_truck.inventory.map do |item, quantity|
        item
      end
    end.uniq
  end

  def total_inventory
    items_list.each_with_object({}) do |item, items_data|
      items_data[item] = {quantity: 0, food_trucks: []}
      food_trucks_that_sell(item).each do |food_truck|
        items_data[item][:food_trucks] << food_truck
        items_data[item][:quantity] += food_truck.check_stock(item)
      end
    end
  end

  def overstocked_items
    total_inventory.map do |item, food_trucks_and_quantities|
      item if food_trucks_and_quantities[:quantity] > 50 && food_trucks_that_sell(item).length > 1
    end.compact
  end

  def sorted_item_list
    items_list.map do |item|
      item.name
    end.sort
  end

  def date
    Date.today.strftime("%d/%m/%Y")
  end
end