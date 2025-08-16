class CreateBookReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :book_reservations do |t|
      t.datetime :start_at, null: false
      t.datetime :finished_at, null: true
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :book_reservations, [ :book_id ], name: "active_book_reservation", unique: true, where: "finished_at IS NULL"
  end
end
