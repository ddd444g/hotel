class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.integer :total_people
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
