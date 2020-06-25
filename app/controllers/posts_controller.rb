class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts=Post.all
  end


  def new
    @post=Post.new
  end
  
  def create
    @post=Post.new(posts_params)
    @post.user = current_user
    
    if @post.save
      redirect_to root_path, notice: "投稿しました！！！"
    else
      redirect_to root_path, notice: "投稿に失敗しました"
    end
    
  end
  
  private
  def posts_params
    params.require(:post).permit(:title, :text, :img, :url, :user_id)
  end

  
end
