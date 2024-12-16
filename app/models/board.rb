class Board < ApplicationRecord
  has_many :board_mines

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :width, presence: true, numericality: { only_integer: true }
  validates :height, presence: true, numericality: { only_integer: true }

  scope :recent, -> { order(created_at: :desc) }
  scope :filter_by_params, ->(params) {
    boards = all
    boards = boards.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    boards = boards.where("email ILIKE ?", "%#{params[:email]}%") if params[:email].present?
    boards = boards.where(width: params[:width]) if params[:width].present?
    boards = boards.where(height: params[:height]) if params[:height].present?
    boards = boards.joins(:board_mines)
                   .group("boards.id")
                   .having("COUNT(board_mines.id) = ?", params[:mines_count]) if params[:mines_count].present?
    boards
  }
end
