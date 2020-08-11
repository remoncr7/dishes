require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = build(:post)
  end

  it 'FactoryBotで作成したpostは登録できる' do
    expect(@post.valid?).to eq(true)
  end

  it 'titleが空だとNG' do
    @post.title = ''
    expect(@post.valid?).to eq(false)
  end

  it 'imgが空だとNG' do
    @post.img = ''
    expect(@post.valid?).to eq(false)
  end

  describe 'titleの文字数' do
    context('titleが15文字以内のとき')
    it '投稿できる' do
      @post.title = 'a' * 15
      expect(@post).to be_valid
    end

    context('titleが16文字以上のとき')
    it '投稿できない' do
      @post.title = 'a' * 16
      expect(@post).not_to be_valid
    end
  end

  describe 'キャプションの文字数' do
    context('textが400文字以内のとき')
    it '投稿できる' do
      @post.text = 'a' * 400
      expect(@post).to be_valid
    end

    context('textが401文字以上のとき')
    it '投稿できない' do
      @post.text = 'a' * 401
      expect(@post).not_to be_valid
    end
  end

  it 'httpから始まるurlは登録できる' do
    @post.url = 'http://example.com'
    expect(@post).to be_valid
  end

  it 'urlがhttpまたはhttpsから始まらない値が入力されたときNG' do
    @post.url = 'htt://example.com'
    expect(@post).not_to be_valid
  end

  # it '画像ファイルが5MBバイト以上はNG' do
  #   @post.img = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/IMG_3777.PNG'))
  #   expect(@post).not_to be_valid
  # end

  it 'jpg jpeg gif png以外のファイルタイプはNG' do
    @post.img = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/IMG_3393 2.HEIC'))
    expect(@post).not_to be_valid
  end
end
