# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :set_board, only: [:show]

  def index
    @boards = Board.recent
  end

  def create
    ActiveRecord::Base.transaction do
      @board = Board.create(board_params.except(:mines_count))

      unless @board.save
        flash[:error] = @board.errors.full_messages.join(". ")
        return redirect_back(fallback_location: root_path)
      end

      board_service = BoardService.new
      @board_matrix = board_service.add_mines @board, board_params[:mines_count].to_i
    end

    flash[:notice] = 'Board Created'
    redirect_back(fallback_location: root_path)
  rescue StandardError => e
    flash[:error] = "Board creation failed: #{e.message}"
    redirect_back(fallback_location: root_path)
  end

  def show
    board_service = BoardService.new

    @board_matrix = board_service.get_matrix @board
  end

  private

  def set_board
    @board = Board.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Board not found"
    redirect_back(fallback_location: root_path)
  end

  def board_params
    params.require(:board).permit(:name, :email, :width, :height, :mines_count)
  end
end
