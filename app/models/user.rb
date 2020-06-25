class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  has_many :posts
  def self.guest
    find_or_create_by!(email: 'guest@example.com' ) do |user|
      user.name = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      user.birth_date =  Date.new(1989, 1, 1)
      user.confirmed_at = Time.now  
    end
  end
end
