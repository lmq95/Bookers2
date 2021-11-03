class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @range = params[:range]
    
    if  @range == "User"
      @user = User.looks(params[:search], params[:word])
      @word = params[:word]
    else
      @book = Book.looks(params[:search], params[:word]) 
      @word = params[:word]
    end
  end

end
