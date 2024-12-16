require 'rails_helper'

RSpec.describe BoardService do
  let(:service) { BoardService.new }

  describe "#add_mines" do
    let(:board) { create(:board, width: 10, height: 10) }
    let(:service) { BoardService.new }

    context "with valid parameters" do
      it "adds the specified number of mines to the board" do
        count = 5
        expect {
          service.add_mines(board, count)
        }.to change { board.board_mines.count }.by(count)
      end

      it "adds exact number of mines to the board" do
        count = board.width * board.height
        expect {
          service.add_mines(board, count)
        }.to change { board.board_mines.count }.by(count)
      end

      it "does not add any mines if the board is full" do
        count = board.width * board.height
        expect {
          service.add_mines(board, count + 5)
        }.to change { board.board_mines.count }.by(count)
      end

      it "returns the updated matrix of mines" do
        count = 5
        matrix = service.add_mines(board, count)
        expect(matrix.count).to eq(board.height)
        expect(matrix[0].count).to eq(board.width)
      end
    end

    context "with different dimensions" do
      let(:board) { create(:board, width: 10, height: 8) }

      it "returns the updated matrix of mines" do
        count = 80
        expect {
          service.add_mines(board, count)
        }.to change { board.board_mines.count }.by(count)

        matrix = service.get_matrix(board)
        expect(matrix.count).to eq(board.height)
        expect(matrix[0].count).to eq(board.width)
      end

    end

    context "with small dimensions" do
      let(:board) { create(:board, width: 10, height: 10) }

      it "returns the updated matrix of mines" do
        count = 50
        expect {
          service.add_mines(board, count)
        }.to change { board.board_mines.count }.by(count)

        matrix = service.get_matrix(board)
        expect(matrix.count).to eq(board.height)
        expect(matrix[0].count).to eq(board.width)
      end

    end

    context "with medium dimensions" do
      let(:board) { create(:board, width: 100, height: 100) }

      it "returns the updated matrix of mines" do
        count = 9995
        expect {
          service.add_mines(board, count)
        }.to change { board.board_mines.count }.by(count)

        matrix = service.get_matrix(board)
        expect(matrix.count).to eq(board.height)
        expect(matrix[0].count).to eq(board.width)
      end

    end

    context "with large dimensions" do
      let(:board) { create(:board, width: 1000, height: 1000) }

      it "returns the updated matrix of mines" do
        count = 500000
        expect {
          service.add_mines(board, count)
        }.to change { board.board_mines.count }.by(count)

        matrix = service.get_matrix(board)
        expect(matrix.count).to eq(board.height)
        expect(matrix[0].count).to eq(board.width)
      end
    end

    context "with invalid parameters" do
      it "does not add any mines if count is zero" do
        count = 0
        expect {
          service.add_mines(board, count)
        }.not_to change { board.board_mines.count }
      end

      it "updates the matrix of mines for each added mine" do
        count = 5
        matrix = service.add_mines(board, count)
        board.board_mines.each do |mine|
          expect(matrix[mine.y][mine.x]).to eq(1)
        end
      end
    end
  end

  describe "#get_matrix" do
    let(:board) { create(:board) }

    context "when there are no mines on the board" do
      it "returns a matrix with all 0's" do
        matrix = service.get_matrix(board)
        expect(matrix).to eq(Array.new(board.height) { Array.new(board.width, 0) })
      end
    end

    context "when there are mines on the board" do
      let!(:board_mine_1) { create(:board_mine, board: board) }
      let!(:board_mine_2) { create(:board_mine, board: board, x: 1, y: 3) }

      it "returns a matrix with 1's on the positions where there are mines" do
        matrix = service.get_matrix(board)
        [board_mine_1, board_mine_2].each do |mine|
          expect(matrix[mine.y][mine.x]).to eq(1)
        end
      end
    end
  end
end
