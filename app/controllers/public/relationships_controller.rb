class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(@customer)
  end

  def destroy
    @customer = Customer.find(params[:customer_id]) # ここを変更
    current_customer.unfollow(params[:id])
  end
end