class Minefield
  attr_reader :row_count, :column_count, :field

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mine_count = mine_count
    @field = create_field
  end

  def create_field
    blanks = [0] * ((@row_count * @column_count) - @mine_count)
    mines = [1] * @mine_count
    field = blanks.concat(mines).shuffle.each_slice(@row_count).to_a
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    cell = @field[row][col]
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?

    false
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?

    false
  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)

    false
  end

  def contains_mine?(row, col)
    @field[row][col] == 1
  end

  def adjacent_mines(row, col)
    mines = 0

    if !@field[row][col-1].nil? then mines += @field[row][col-1]
    if !@field[row][col+1].nil? then mines += @field[row][col+1]
    if !@field[row-1][col-1].nil? then mines += @field[row-1][col-1]
    if !@field[row-1][col].nil? then mines += @field[row-1][col]
    if !@field[row-1][col+1].nil? then mines += @field[row-1][col+1]
    if !@field[row+1][col-1].nil? then mines += @field[row+1][col-1]
    if !@field[row+1][col].nil? then mines += @field[row+1][col]
    if !@field[row+1][col+1].nil? then mines += @field[row+1][col+1]
  end
end
