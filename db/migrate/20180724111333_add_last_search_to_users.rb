class AddLastSearchToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_search, :string
  end
end
