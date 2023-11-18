class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :start, null: false
      t.date :end, null: false
      t.integer :people, null: false

      t.timestamps
    end
  end
end
