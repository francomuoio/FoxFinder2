class AddResultToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_company_result_id, :string
    add_column :users, :second_company_result_id, :string
    add_column :users, :third_company_result_id, :string
  end
end
