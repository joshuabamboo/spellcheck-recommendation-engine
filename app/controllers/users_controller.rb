class UsersController < ApplicationController

  def index
    
  end

  def search
    @user_name = params[:name]
    ld = LevenshteinDistance.new
    @match = ld.get_closest_match(@user_name)
    @id = ld.get_closest_match_id
  end

end