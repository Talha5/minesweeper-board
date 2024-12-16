class BoardMine < ApplicationRecord
  belongs_to :board

  validates :x, presence: true, numericality: { only_integer: true }
  validates :y, presence: true, numericality: { only_integer: true }

  validates_uniqueness_of :board, :scope => [:x, :y]
end
