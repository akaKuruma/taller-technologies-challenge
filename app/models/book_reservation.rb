class BookReservation < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :start_at, presence: true
  validates :book, presence: true
  validates :user, presence: true
  validates_uniqueness_of :book, conditions: -> { where.not(finished_at: nil) }, message: "has already been taken"

  after_initialize :set_start_at

  private

  def set_start_at
    self.start_at ||= Time.current
  end
end
