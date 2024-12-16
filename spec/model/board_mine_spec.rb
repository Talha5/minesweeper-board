require 'rails_helper'

RSpec.describe BoardMine, type: :model do
  let(:board) { create(:board, name: "Example Board", email: "board@example.com", width: 1, height: 10) }

  describe "validations" do
    it "is valid with valid attributes" do
      board_mine = BoardMine.new(x: 1, y: 2, board: board)
      expect(board_mine).to be_valid
    end

    it "is not valid without an x value" do
      board_mine = BoardMine.new(y: 2, board: board)
      expect(board_mine).not_to be_valid
    end

    it "is not valid without a y value" do
      board_mine = BoardMine.new(x: 1, board: board)
      expect(board_mine).not_to be_valid
    end

    it "is not valid without a board" do
      board_mine = BoardMine.new(x: 1, y: 2)
      expect(board_mine).not_to be_valid
    end

    it "is not valid with non-integer x value" do
      board_mine = BoardMine.new(x: "abc", y: 2, board: board)
      expect(board_mine).not_to be_valid
    end

    it "is not valid with non-integer y value" do
      board_mine = BoardMine.new(x: 1, y: "def", board: board)
      expect(board_mine).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a board" do
      association = described_class.reflect_on_association(:board)
      expect(association.macro).to eq :belongs_to
    end
  end
end