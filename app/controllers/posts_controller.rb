class PostsController < ApplicationController
  def index

  end
  def show
  end
  def new

  end
  def create
    Post.create(post_params)

    redirect_to root_path
  end
  def edit
  end
  def update
  end
  def post_params
    params.require(:post).permit(:description, :image, :user_id)
  end
end