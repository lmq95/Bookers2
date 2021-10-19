class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end
    
  def edit
    @user = User.find(params[:id])
  end
  
  def update
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
