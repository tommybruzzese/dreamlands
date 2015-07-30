class User <  ActiveRecord::Base
  has_many :dreams
  accepts_nested_attributes_for :dreams
  
  
end