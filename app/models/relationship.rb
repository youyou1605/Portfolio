class Relationship < ApplicationRecord
  belongs_to :followed, class_name: 'Customer', foreign_key: 'followed_id'
  belongs_to :follower, class_name: 'Customer', foreign_key: 'follower_id'

  with_options presence: true do
    validates :followed_id
    validates :follower_id
  end
end