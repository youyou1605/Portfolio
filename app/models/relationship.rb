class Relationship < ApplicationRecord
  belongs_to :customer
  belongs_to :follower, class_name: 'Customer'

  with_options presence: true do
    validates :customer_id
    validates :follower_id
  end
end
