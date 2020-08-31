class PostsController < ApplicationController
  def index
    @post = Post.all
  end
  def show
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post added"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end

  end
  def edit
  end
  def update
  end
  def post_params
    params.require(:post).permit(:description, :image, :user_id, :remove_image)
  end
end