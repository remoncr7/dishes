class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @posts=Post.all
  end

  def my_post 
    @posts = current_user.posts.all
  end

  def new
    @post=Post.new
  end
  
  def create
    @post=Post.new(posts_params)
    @post.user = current_user
    # @post.save
    if @post.save
      redirect_to root_path, notice: "投稿しました！"
    else
      render :new
    end
    
  end
  
  private
  def posts_params
    params.require(:post).permit(:title, :text, :img, :url, :user_id)
  end

  
end
