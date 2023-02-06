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
  end

  def edit
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :introduction)
  end
end
  def current_customer
    @post = Post.find(params[:post_id])
    @customer = @post.customer
    redirect_to(public_posts_path) unless @customer == current_cutomer
  end


