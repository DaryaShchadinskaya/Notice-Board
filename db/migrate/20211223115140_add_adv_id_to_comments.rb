class AddAdvIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :adv_id, :int
  end
end
