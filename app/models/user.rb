class User < ActiveRecord::Base
  
  def self.all_users
    User.all
  end

end
