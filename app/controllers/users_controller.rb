class UsersController < ApplicationController

  def index
    @users = User.all.order("username ASC") 
  end


  def show
  @user = User.friendly.find(params[:id]) 
  end

  
end
