class AddLockVersionToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :lock_version, :integer
  end
end
