class Board < ApplicationRecord
  has_many :board_mines

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :width, presence: true, numericality: { only_integer: true }
  validates :height, presence: true, numericality: { only_integer: true }

  scope :recent, -> { order(created_at: :desc) }
end
