class Admin::PostsController < ApplicationController
   before_action :authenticate_admin!

  def new
    @post = Post.new
  end

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_posts_path
    else
      flash[:post_created_error] = "投稿情報が保存されませんでした"
      redirect_to admin_posts_new_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to admin_posts_path(@post)
    else
       flash[:post_updated_error] = "投稿情報が保存されませんでした"
       redirect_to admin_posts_edit_path(@post)
    end
  end

  private
  def post_params
    params.require(:post).permit(:id,:customer_id,:title,:introduction)
  end
end
