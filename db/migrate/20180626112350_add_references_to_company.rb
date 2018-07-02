class AddReferencesToCompany < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :negociators, foreign_key: true
    add_reference :companies, :properties, foreign_key: true
    add_reference :properties, :negociators, foreign_key: true
  end
end
