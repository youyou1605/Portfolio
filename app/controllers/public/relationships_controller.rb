class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = Customer.find(params[:follower])
    current_customer.follow(@customer)
  end
  
  def destroy
    @customer = current_customer.relationships.find(params[:id]).follower
    current_customer.unfollow(params[:id])
  end
end
