class AddUserIdToDreams < ActiveRecord::Migration
  def up
    add_column :dreams, :user_id, :integer
  end
  
  def down
    remove_column :dreams, :user_id, :integer
  end
end
