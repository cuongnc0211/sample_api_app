module Api
  class V1::BooksController < BaseController
    before_action :load_book, only: [:show, :delete, :update]

    # GET api/v1/books
    def index
      @pagy, @books = pagy(Book.all)

      render json: {
        books: @books,
        success: :true,
        meta: meta_attributes(@pagy)
      }, status: 200
    end

    def show
      render json: {
        book: @book,
        success: :true,
      }, status: 200
    end

    private

    def load_book
      @book = Book.find(params[:id])
    end
  end
end
