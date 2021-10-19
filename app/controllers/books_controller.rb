class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    if @book.user_id = current_user.id
       @book.save
       flash[:notice] = "Book was successfully created."
       redirect_to book_path(@book)
    else
       flash.now[:alert]
       @books = Book.all
       render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "Book was successfully updated."
       redirect_to book_path
    else
      flash.now[:alert]
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end
  

  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
end
