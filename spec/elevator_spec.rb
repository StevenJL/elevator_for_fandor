require 'spec_helper'
require_relative '../elevator'

describe Floor do
  it "register floor calls to the elevator" do
    controller = Controller.new(10)
    ground_floor = controller.floors[0]
    second_floor = controller.floors[2]
    fifth_floor = controller.floors[5]
    ground_floor.push_up
    second_floor.push_down
    fifth_floor.push_down

    controller.register_floor_calls
    controller.elevator.up_floors.should include(0)
    controller.elevator.down_floors.should include(2)
    controller.elevator.down_floors.should include(5)
  end
end

describe Elevator do
  it "updates target floor and floor queues correctly" do
    controller = Controller.new(10)
    elevator = controller.elevator
    elevator.current_target.should be_nil
    elevator.push_button_inside_elevator(5)
    elevator.update_target
    elevator.current_target.should == 5
  end

  it "goes to the correct floor" do
    controller = Controller.new(10)
    elevator = controller.elevator
    elevator.push_button_inside_elevator(5)
    elevator.update_target
    elevator.move_to_target
    elevator.current_floor.should == 5
  end

end