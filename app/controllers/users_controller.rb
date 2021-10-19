class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)  
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
