class User <  ActiveRecord::Base
  has_many :dreams
#   accepts_nested_attributes_for :dreams
   include BCrypt

  def password
    @password = Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  
  
end