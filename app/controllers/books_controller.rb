class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all       #index.htmlの表示には@bookと@booksが必要！
  end

  def create
    @book = Book.new(book_params)     #renderでhtmlファイルに飛ぶときはbookではなく@bookにする！
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all       #createアクション内に@booksの定義がないから、indexに飛ぶ前に定義する！
      render action: :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
  end

  def edit
    @book = Book.find(params[:id])      #edit.htmlの表示には@bookのみが必要！
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render action: :edit      #@bookはupdateアクション内ですでに定義されているので再定義不要！
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to books_path
    else
      @books = Book.all
      render action :index
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
