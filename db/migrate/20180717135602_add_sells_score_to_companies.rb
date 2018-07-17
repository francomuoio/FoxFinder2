class AddSellsScoreToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :sells_score, :integer, default: 0
  end
end
