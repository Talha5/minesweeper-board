# frozen_string_literal: true

FactoryBot.define do
  factory :board_mine do
    board { create(:board) }
    x { 0 }
    y { 0 }
  end
end
