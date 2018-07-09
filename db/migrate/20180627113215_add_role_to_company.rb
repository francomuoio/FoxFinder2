class AddRoleToCompany < ActiveRecord::Migration[5.2]
  def change
     add_column :companies, :role, :integer, default: 0
  end
end
