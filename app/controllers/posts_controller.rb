class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
      flash[:notice] = "Post successfully submitted."
    else
      render :new
      flash[:notice] = "Post could not be submitted."
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.save
      redirect_to root_path
      flash[:notice] = "Post successfully updated."
    else
      render :edit
      flash[:notice] = "Post could not be updated."
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
    flash[:notice] = "Post successfully deleted."
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(
      :title,
      :content,
    )
  end

end
