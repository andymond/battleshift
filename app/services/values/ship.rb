class Ship
  attr_reader :length, :damage, :start_space,
              :end_space

  def initialize(params = {})
    @length = params[:ship_size]
    @damage = 0
    @start_space = params[:start_space]
    @end_space = params[:end_space]
  end

  def place(start_space, end_space)
    @start_space = start_space
    @end_space = end_space
  end

  def attack!
    @damage += 1
  end

  def is_sunk?
    @damage == @length
  end
end
