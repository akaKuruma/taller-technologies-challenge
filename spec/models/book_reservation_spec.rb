require 'rails_helper'

RSpec.describe BookReservation, type: :model do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  subject(:book_reservation) { build(:book_reservation, book: book, user: user) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_presence_of(:user) }

    context "when creating a new book reservation" do
      context "and start_at is not given" do
        let(:frozen_time) { Time.new(2025, 8, 15, 12, 0, 0) }

        around do |example|
          travel_to frozen_time do
            example.run
          end
        end

        it { is_expected.to be_valid }
        it { expect(book_reservation.start_at).to eq(frozen_time) }
      end

      context "but a reservation already exists for the book" do
        let!(:existing_reservation) { create(:book_reservation, book: book, user: user) }

        it "is invalid with message 'Book has already been taken'" do
          is_expected.to be_invalid
          expect(book_reservation.errors.full_messages).to include("Book has already been taken")
        end
      end
    end
  end
end
