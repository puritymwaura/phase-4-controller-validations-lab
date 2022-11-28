class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    render json: post
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.messages }, status: :unprocessable_entity
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid) 
  render json: { errors: invalid.errors.full_messages }, status: :unprocessable_entity
  end

end
