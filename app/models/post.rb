class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 15, too_long: "は%{count}文字以内で設定してください "}
  validates :img, presence: true
  validates :text, length: { maximum: 400, too_long: "は%{count}文字以内で設定してください "}
  validates :url, {:allow_blank => true, format: /\A#{URI::regexp(%w(http https))}\z/}
  belongs_to :user
  mount_uploader :img, ImgUploader
end
 