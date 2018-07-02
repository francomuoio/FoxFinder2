class CreateProperty < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :property_type
      t.string :property_nbr
      t.date :property_date
      t.string :mandat_type
      t.date :mandat_date
      t.date :compromis_date
      t.string :address
      t.integer :price
      t.boolean :fake
    end
  end
end
