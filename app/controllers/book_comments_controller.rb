class BookCommentsController < ApplicationController

def create
  @book = Book.find(params[:book_id])
  @book_comment = BookComment.new(book_comment_params)
  @book_comment.book_id = @book.id
  @book_comment.user_id = current_user.id
  if @book_comment.save
     render :index
  else
     render 'books/show'
  end
end

def destroy
  BookComment.find_by(id: params[:id]).destroy  
　@book = Book.find(params[:book_id])
　render :index
end

 private

  def book_comment_params
    params.require(:book_comment).permit(:comment)

  end

end
