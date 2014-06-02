class Minefield
  attr_reader :row_count, :column_count, :field

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mine_count = mine_count
    @field = create_field
    @board = create_board
  end

  def create_field
    blanks = [0] * ((@row_count * @column_count) - @mine_count)
    mines = [1] * @mine_count
    blanks.concat(mines).shuffle.each_slice(@row_count).to_a
  end

  def create_board
    ([0] * (@row_count * @column_count)).each_slice(@row_count).to_a
  end

  def clear(row, col)
    @board[row][col] = 1
    if adjacent_mines(row, col) != 0 || @field[row][col] == 1
      return false
    else
      surrounding_cells(row, col)
    end
  end

  def clear_adjacent(row, col)
    if @board[row][col] == 0 && @field[row][col] == 0 && adjacent_mines(row, col) == 0
      @board[row][col] = 1
      surrounding_cells(row, col)
    else
      @board[row][col] = 1
    end
  end

  def surrounding_cells(row, col)
    (-1..1).each do |i|
      (-1..1).each do |j|
        if !(i == 0 && j == 0)
          if board_check?(row+i, col+j) then clear_adjacent(row+i, col+j) end
        end
      end
    end
  end

  def any_mines_detonated?
    @field.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if @field[i][j] == 1 && @board[i][j] == 1
          return true
        end
      end
    end
    false
  end

  def all_cells_cleared?
    blanks = 0
    @field.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if @board[i][j] == 1
          blanks += 1
        end
      end
    end
    blanks == ((@row_count * @column_count) - @mine_count)
  end

  def cell_cleared?(row, col)
    @board[row][col] == 1
  end

  def contains_mine?(row, col)
    @field[row][col] == 1
  end

  def board_check?(row, col)
    row >= 0 && col >= 0 && row < @row_count && col < @column_count
  end

  def adjacent_mines(row, col)
    mines = 0
    (-1..1).each do |i|
      (-1..1).each do |j|
        if !(i == 0 && j == 0)
          if board_check?(row+i, col+j) then mines += @field[row+i][col+j] end
        end
      end
    end
    mines
  end
end


