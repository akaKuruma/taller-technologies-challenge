class Book < ApplicationRecord
  has_many :book_reservations, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true

  def available?
    book_reservations.where(finished_at: nil).none?
  end

  def reserved?
    book_reservations.where(finished_at: nil).any?
  end
end
