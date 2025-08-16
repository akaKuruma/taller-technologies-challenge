require "rails_helper"

RSpec.describe "Book Reservations", type: :request do
  describe "POST /book/:id/reserve" do
    let(:book) { create(:book) }
    let(:user) { create(:user) }

    context "when the book is available" do
      it "creates a new book reservation" do
        expect {
          post book_reserve_index_path(book), params: { book_reservation: { user_id: user.id } }, as: :json
        }.to change(book, :available?).from(true).to(false)
      end
    end

    context "when the book is not available" do
      let!(:book_reservation) { create(:book_reservation, book: book, user: user) }

      it "does not create a new book reservation" do
        expect {
          post book_reserve_index_path(book), params: { book_reservation: { user_id: user.id } }, as: :json
        }.not_to change(book, :reserved?).from(false)

        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)["errors"]).to include("Book has already been taken")
      end
    end
  end
end
