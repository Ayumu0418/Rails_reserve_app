class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :hotel_name, null: false
      t.text :hotel_detail, null: false
      t.integer :hotel_price, null: false
      t.text :hotel_address, null: false
      t.string :hotel_image

      t.timestamps
    end
  end
end
