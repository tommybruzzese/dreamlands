class CreateDreams < ActiveRecord::Migration
  def up
    create_table :dreams do |t|
      t.string :date
      t.string :description
      t.string :emotion
      t.string :people
      t.string :keywords
      t.string :interpretation
    end
  end
    
  def down 
    drop_table :dreams
  end
end
