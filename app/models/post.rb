class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 15 }
  validates :img, presence: true
  validates :text, length: { maximum: 400 }
  validates :url, { allow_blank: true, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/ }
  belongs_to :user
  has_many :likes, dependent: :destroy
  mount_uploader :img, ImgUploader
end
