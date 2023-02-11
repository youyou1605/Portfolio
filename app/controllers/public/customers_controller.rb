class Public::CustomersController < ApplicationController
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

   private

  def customer_params
    params.require(:customer).permit(:user_name,:profile_image,:introduction,:is_deleted)
  end
end
def correct_customer
    @post = Post.find(params[:id])
    @customer = @post.customer
    redirect_to(public_posts_path) unless @customer == current_customer

end
