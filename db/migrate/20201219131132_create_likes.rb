class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :ip_address, null: false, limit: 15
      t.belongs_to :message
      t.timestamp :created_at
    end
    add_index :likes, [:ip_address, :message_id], unique: true
  end
end
