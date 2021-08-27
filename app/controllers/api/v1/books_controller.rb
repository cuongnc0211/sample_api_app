module Api
  class V1::BooksController < BaseController
    before_action :load_book, only: [:show, :destroy, :update]

    # GET api/v1/books
    def index
      @pagy, @books = pagy(Book.all)

      render json: {
        books: @books,
        success: :true,
        meta: meta_attributes(@pagy)
      }, status: 200
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        render json: {
          book: @book,
          success: :true,
        }, status: 201
      else
        render json: {
          book: @book,
          success: :false,
          message: @book.errors.full_messages,
        }, status: 403
      end
    end

    def show
      render json: {
        book: @book,
        success: :true,
      }, status: 200
    end

    def update
      if @book.update(book_params)
        render json: {
          book: @book,
          success: :true,
        }, status: 201
      else
        render json: {
          book: @book,
          success: :false,
          message: @book.errors.full_messages,
        }, status: 403
      end
    end

    def destroy
      if @book.delete
        render json: {
          message: 'delete successfully',
          success: :true,
        }, status: 201
      else
        render json: {
          success: :false,
          message: 'delete failed',
        }, status: 403
      end
    end

    private

    def load_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.permit(:title, :author, :publisher, :genre)
    end
  end
end
