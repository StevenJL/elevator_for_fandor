class Controller
  attr_accessor :floors, :elevator

  def initialize(num_of_floors)
    @elevator = Elevator.new
    @floors = []
    @floors << Floor.new(0, {:no_down=>true})
    (1..num_of_floors-2).each do |index|
      @floors << Floor.new(index)
    end
    @floors << Floor.new(num_of_floors-1, {:no_up=>true})
  end

  def register_floor_calls
    @elevator.up_floors = @floors
        .select { |floor| floor.pushed_up }
        .map { |floor| floor.floor_number }
    @elevator.down_floors = @floors
        .select { |floor| floor.pushed_down }
        .map { |floor| floor.floor_number }
  end

end

class Elevator
  attr_accessor :current_floor, :up_floors, :down_floors, :current_target,
                :queued_floors, :direction

  def initialize
    @current_floor = 0
    @queued_floors = []
    @up_floors = []
    @down_floors = []
    @current_target = nil
    @direction = 0
  end

  def update_target
    @current_target =  queued_floors.shift
    @current_target = up_floors.shift unless current_target
    @current_target = down_floors.shift unless current_target
  end

  def push_button_inside_elevator(floor_number)
    @queued_floors << floor_number
  end

  def open_door
    puts "Ding! Welcome to floor #{current_floor}!"
  end

  def move_to_target
    if (@current_target > @current_floor)
      @direction = 1
      stop_floors = up_floors
    else
      @direction = -1
      stop_floors = down_floors
    end
    while @current_target != @current_floor
      @current_floor += @direction
      open_door if stop_floors.include?(@current_floor)
    end
  end

end

class Floor
  attr_accessor :floor_number, :pushed_up, :pushed_down

  def initialize(floor_number, options={})
    @floor_number = floor_number
    if options[:no_up]
      @pushed_down = false
    elsif options[:no_down]
      @pushed_up = false
    else
      @pushed_down = false
      @pushed_up = false
    end
  end

  def push_up
    @pushed_up = true
  end

  def push_down
    @pushed_down = true
  end

end