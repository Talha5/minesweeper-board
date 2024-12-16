# frozen_string_literal: true

class BoardService < ApplicationService

  # Adds mines to the given board.
  def add_mines(board, count)
    # Initialize the board matrix
    matrix = get_matrix(board)

    # Check if mines can be added to the board
    total_cells_count = board.height * board.width
    board_cells_count = board.board_mines.count
    return matrix if count <= 0 || board_cells_count >= total_cells_count

    # Calculate available cells count
    available_cells_count = total_cells_count - board_cells_count

    # Adjust count if adding mines would exceed the board's capacity
    count = available_cells_count if count > available_cells_count

    # Generate mines
    mines = generate_mines(matrix, count, board)

    # Save the mines' coordinates to the BoardMine model
    BoardMine.insert_all(mines)

    # Update matrix with new mines
    update_matrix_with_mines(matrix, mines)

    matrix
  end

  # Initializes a matrix representing the given board.
  def get_matrix(board)
    # Initialize an empty matrix with the same dimensions as the board
    matrix = Array.new(board.height) { Array.new(board.width, 0) }
    
    # Set the cell values to 1 for cells containing mines
    board.board_mines.each do |mine|
      matrix[mine.y][mine.x] = 1
    end

    matrix
  end

  private

  # Generates a specified number of mines within the given matrix.
  def generate_mines(matrix, count, board)
    available_cells = matrix.each_index.flat_map do |y|
      matrix[y].each_index.map { |x| { y: y, x: x } if matrix[y][x].zero? }
    end.compact

    available_cells.sample(count).map do |cell|
      { board_id: board.id, x: cell[:x], y: cell[:y] }
    end
  end

  # Updates the given matrix with the specified mines.
  def update_matrix_with_mines(matrix, mines)
    mines.each do |mine|
      matrix[mine[:y]][mine[:x]] = 1
    end
  end
end
