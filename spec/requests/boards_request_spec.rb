require 'rails_helper'

RSpec.describe BoardsController, type: :request do
  let(:valid_attributes) { { name: "Test", email: "test@example.com", width: 10, height: 8 } }
  let(:invalid_attributes) { { name: "", email: "test@example.com", width: "invalid", height: 8 } }
  let(:board) { create(:board, valid_attributes) }

  describe "GET /boards" do
    it "renders a successful response" do
      get boards_path
      expect(response).to be_successful
    end
  end

  describe "POST /boards" do
    context "with valid parameters" do
      it "creates a new board" do
        expect {
          post boards_path, params: { board: valid_attributes }
        }.to change(Board, :count).by(1)
      end

      it "redirects to the created board" do
        post boards_path, params: { board: valid_attributes }
        expect(response).to redirect_to(board_path(Board.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new board" do
        expect {
          post boards_path, params: { board: invalid_attributes }
        }.to change(Board, :count).by(0)
      end
    end
  end

  describe "GET /boards/:id" do
    it "renders a successful response" do
      get board_path(board)
      expect(response).to be_successful
    end
  end
end