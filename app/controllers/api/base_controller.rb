class Api::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {
      messages: exception.message,
      success: :fail,
    }, status: 404
  end

  protected

  def meta_attributes(paginate_object, extra_meta = {})
    {
      current_page: paginate_object.try(:page),
      next_page: paginate_object.try(:next),
      prev_page: paginate_object.try(:prev),
      items_count: paginate_object.try(:items),
      total_pages_count: paginate_object.try(:pages)
      total_count: paginate_object.try(:count)
    }.merge(extra_meta)
  end
end
