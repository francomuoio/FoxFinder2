class AddReferencesToNegociator < ActiveRecord::Migration[5.2]
  def change
    add_reference :negociators, :companies, foreign_key: true
  end
end
