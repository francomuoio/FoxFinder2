class AddSiegeInfoToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :sub, :boolean
    add_column :companies, :siege, :boolean
  end
end
