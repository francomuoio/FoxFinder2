class AddCompromisAndMandatTimeToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :mandat_time, :string
    add_column :properties, :compromis_time, :string
    add_column :properties, :delay, :string
    add_column :properties, :sells_mark, :string
    add_column :properties, :coefficient, :float, default: 1.0
    add_column :companies, :total_delay, :integer
  end
end
