class Board
  attr_reader :length,
              :board

  def initialize(length = 4)
    @length = check_length(length)
    @board = create_grid
  end

  def check_length(length)
    if length > 26
      26
    elsif length == 0
      4
    else
      length
    end
  end

  def all_sunk?
    board.flatten.all? do |space|
      space.values[0].contents.is_sunk? if space.values[0].occupied?
    end
  end

  def space_names
    get_row_letters.map do |letter|
      get_column_numbers.map do |number|
        letter + number
      end
    end.flatten
  end

  def create_spaces
    space_names.map do |name|
      [name, Space.new(name)]
    end.to_h
  end

  def assign_spaces_to_rows
    space_names.each_slice(@length).to_a
  end

  def create_grid
    spaces = create_spaces
    assign_spaces_to_rows.map do |row|
      row.each.with_index do |coordinates, index|
        row[index] = {coordinates => spaces[coordinates]}
      end
    end
  end

  def get_row_letters
    ("A".."Z").to_a.shift(@length)
  end

  def get_column_numbers
    ("1".."26").to_a.shift(@length)
  end

  def locate_space(coordinates)
    @board.each do |row|
      row.each do |space_hash|
        return space_hash[coordinates] if space_hash.keys[0] == coordinates
      end
    end
  end

  def all_placed?
    if placed_count == 5
      true
    else
      false
    end
  end

  def placed_count
    @board.flatten.sum do |space|
      if !space.values[0].contents.nil?
        1
      else
        0
      end
    end
  end
end
