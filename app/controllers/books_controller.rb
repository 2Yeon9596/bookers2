class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to books_path
    else
      @books = Book.all
      @user = current_user
      render :index, status: :unprocessable_entity
    end    
  end   

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user 
      redirect_to books_path
    end
  end   

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end  
  end  

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end  
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
