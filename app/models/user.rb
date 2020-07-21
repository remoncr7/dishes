class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true,  length: { maximum: 15 }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post, dependent: :destroy

  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com' ) do |user|
      user.name = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now  
    end
  end
end
