class AddSubdomainToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :subdomain, :text
  end
end
