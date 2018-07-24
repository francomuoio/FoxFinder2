class AddSiegeIdToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :siege_id, :integer
  end
end
