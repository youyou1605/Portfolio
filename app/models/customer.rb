class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,         dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :customer

  has_one_attached :profile_image

  validates :user_name, {presence: true,uniqueness: true, length: {maximum: 20,minimum:2}}
  validates :introduction, {length: {maximum: 50}}

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(user_name: 'guestuser' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.user_name = "guestuser"
    end
  end

  def following?(customer)
    followings.include?(customer)
  end

  def follow(customer_id)
    relationships.create(follower: customer_id)
  end

  def unfollow(relationship_id)
    relationships.find(relationship_id).destroy!
  end

 def liked_by?(post_id)
    favorites.where(post_id: post_id).exists?
 end
end
