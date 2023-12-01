class AddUserIdToRooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :user, foreign_key: true, null: true
  end
end
