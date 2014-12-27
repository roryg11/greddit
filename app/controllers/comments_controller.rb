class CommentsController < ApplicationController
  before_action :set_post, :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment= @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
      flash[:notice] = "Comment succcessfully added."
    else
      render :new
      flash[:notice] = "Comment could not be added."
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])
    @comment.update(comment_params)
    if @comment.save
      redirect_to post_path(@post)
      flash[:notice] = "Comment successfully updated."
    else
      render :edit
      flash[:notice] = "Comment could not be updated."
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
    flash[:notice] = "Comment was successfully deleted."
  end

  private
  def comment_params
    params.require(:comment).permit(
      :content,
      :user_id,
      :post_id,
    )
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
