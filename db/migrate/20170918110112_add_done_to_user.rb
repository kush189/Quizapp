class AddDoneToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :done, :text
  end
end
