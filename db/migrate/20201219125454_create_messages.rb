class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :author, null:  false, limit: 50
      t.text :message, null: false, limit: 5000
      t.integer :likes, null: false, default: 0
      t.timestamps
    end
  end
end
