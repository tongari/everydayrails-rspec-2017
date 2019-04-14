class CreateSAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :s_accounts do |t|
      t.references :supplier, foreign_key: true
      t.string :account_number

      t.timestamps
    end
  end
end
