require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/item'
require './lib/food_truck'
require './lib/event'

class EventTest < Minitest::Test
  def setup
    @event = Event.new("South Pearl Street Farmers Market")
  end

  def test_it_exists_with_attributes
    assert_instance_of Event, @event

    assert_equal "South Pearl Street Farmers Market", @event.name 
    assert_equal [], @event.food_trucks
  end
end