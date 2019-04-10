class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :legacy_code

      t.timestamps
    end
  end
end
