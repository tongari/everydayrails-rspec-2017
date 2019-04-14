class AddNameToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :name, :text
    change_column :books, :name, :text, null: false
  end
end
