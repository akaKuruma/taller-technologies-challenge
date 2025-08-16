require 'rails_helper'
RSpec.describe Book, type: :model do
  let(:created_book) { create(:book) }
  let(:user) { create(:user) }

  subject { build(:book) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe "available?" do
    subject { created_book.available? }

    context "when there are no active reservations" do
      let!(:book_reservation) { create(:book_reservation, book: created_book, finished_at: DateTime.yesterday, user: user) }

      it { is_expected.to be_truthy }
    end

    context "when there are active reservations" do
      let!(:book_reservation) { create(:book_reservation, book: created_book, finished_at: nil, user: user) }

      it { is_expected.to be_falsey }
    end
  end

  describe "reserved?" do
    subject { created_book.reserved? }

    context "when there are reservations" do
      let!(:book_reservation) { create(:book_reservation, book: created_book, finished_at: nil, user: user) }

      it { is_expected.to be_truthy }
    end

    context "when there are no reservations" do
      let!(:book_reservation) { create(:book_reservation, book: created_book, finished_at: DateTime.yesterday, user: user) }

      it { is_expected.to be_falsey }
    end
  end
end
