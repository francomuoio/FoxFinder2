class CreateNegociator < ActiveRecord::Migration[5.2]
  def change
    create_table :negociators do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :visibility
    end
  end
end
