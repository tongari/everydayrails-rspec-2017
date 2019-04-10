class RemoveMessageToAccount < ActiveRecord::Migration[5.1]
  def change
    remove_column :accounts, :message, :string
  end
end
