class AddIndexToMessages < ActiveRecord::Migration[5.2]
  def change
    add_index :messages, :likes
    add_index :messages, :created_at
  end
end
