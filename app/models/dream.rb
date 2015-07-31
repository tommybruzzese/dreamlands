class Dream < ActiveRecord::Base
  belongs_to :user
  
  def delete
    self.destroy
  end
  
 
end