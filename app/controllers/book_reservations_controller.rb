class BookReservationsController < ApplicationController
  def create
    @book_reservation = book.book_reservations.build(book_reservation_params)

    respond_to do |format|
      if @book_reservation.save
        format.json { render json: @book_reservation, status: :created }
      else
        format.json { render json: { errors: @book_reservation.errors.full_messages }, status: :unprocessable_content }
      end
    end
  end

  private

  def book
    @book ||= Book.find(params[:book_id])
  end

  def user
    @user ||= User.find(book_reservation_params[:user_id])
  end

  def book_reservation_params
    params.require(:book_reservation).permit(:user_id, :start_at)
  end
end
