class AddCompaniesReferenceToProperties < ActiveRecord::Migration[5.2]
  def change
    add_reference :properties, :companies, foreign_key: true
  end
end
