class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  end


  def new
    @post=Post.new
  end
  
  def create
    @post=Post.new(posts_params)
    @post.user = current_user
    
    if @post.save

    else

    end
    @posts=Post.all
    # redirect_to action: :index
  end
  
  private
  def posts_params
    # binding.pry 
    params.require(:post).permit(:title, :text, :img, :url, :user_id)
  end

  
end
