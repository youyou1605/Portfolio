class Public::CustomersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_customer, only: [:followings, :followers]
  def index
     @customer = current_customer
    @customers = Customer.all
    @post = Post.new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
  end

  def edit
    customer_id = params[:id].to_i
    login_customer_id = current_customer.id
  if(customer_id != login_customer_id)
    redirect_to public_customer_path(current_cutomer)
  end
    @customer = Customer.find(params[:id])
  end

  def update
    customer_id = params[:id].to_i
    login_customer_id = current_customer.id
    if(customer_id != login_customer_id)
      redirect_to public_customer_path(current_customer)
    end
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to public_customer_path(@customer.id)
    else
      @customers = Customer.all
      render :edit
    end
  end

  def followings
    @customers = @customer.followings
  end

  def followers
    @customers = @customer.followers
  end

private

  def customer_params
    params.require(:customer).permit(:id,:user_name,:profile_image,:introduction,:is_deleted)
  end
end
def correct_customer
    @post = Post.find(params[:id])
    @customer = @post.customer
    redirect_to(public_posts_path) unless @customer == current_customer
end
def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.user_name == "guestuser"
      redirect_to public_customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
end

def set_customer
    @customer = Customer.find(params[:id])
  end
