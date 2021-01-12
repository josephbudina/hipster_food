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
    items = Hash.new(0)
    items_list.each do |item|
      items[item] = {quantity: 0, food_trucks: []}
      food_trucks_that_sell(item).each do |food_truck|
        items[item][:food_trucks] << food_truck
        items[item][:quantity] += food_truck.check_stock(item)
      end
    end
    items
  end

  def overstocked_items
    overstocked = []
    total_inventory.each do |item, food_trucks_and_quantities|
      overstocked << item if food_trucks_and_quantities[:quantity] > 50 && food_trucks_that_sell(item).length > 1
    end
    overstocked
  end
end