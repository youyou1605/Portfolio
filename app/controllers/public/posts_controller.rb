class Public::PostsController < ApplicationController
  before_action :correct_customer, only: [:edit, :update]

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to public_posts_path(@post.id)
    else
      @posts = Post.all
      @customer = current_customer
      render :index
    end
  end

  def index
    @post = Post.new
    @posts = Post.all
    @customer = current_customer
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  if @post.update(post_params)
    flash[:notice] = "You have updated post successfully."
    redirect_to public_posts_path(@post.id)
  else
    @posts = Post.all
    @customer = current_customer
    render:index
  end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.customer_id == current_customer.id
      @post.destroy
      redirect_to '/public/posts'
      flash[:notice] = "投稿を削除しました"
    else
      redirect_to '/public/posts'
      flash[:alert] = "他人の投稿は削除できません"
    end
  end

private
  def post_params
   params.require(:post).permit(:title, :introduction)
  end
end
  def correct_customer
    @post = Post.find(params[:id])
    @customer = @post.customer
    redirect_to(public_posts_path) unless @customer == current_customer
  end


