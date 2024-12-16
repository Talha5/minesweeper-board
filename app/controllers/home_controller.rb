class HomeController < ApplicationController
  before_action :set_recent_boards

  def index
    @board = Board.new
  end

  private

  def set_recent_boards
    @recent_boards = Board.recent.includes(:board_mines).limit(10)
  end
end
