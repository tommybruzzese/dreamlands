class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_hash
    end
  end
  
  def down
    down_table :users
  end
end
