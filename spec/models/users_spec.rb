require 'rails_helper'

RSpec.describe User, type: :model do
  #factoriesフォルダ内で定義した「:user」というユーザーをインスタンス変数に格納(FactoryBot)
  before do 
    @user = build(:user)
  end

  describe '#create' do 

    it 'name,email,passwardがあれば登録できる' do
      expect(@user.valid?).to eq(true)
    end

    
    it 'nameが空だとNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'emailが空だとNG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end

    it 'passwardが空だとNG' do
      @user.password = ''
      expect(@user.valid?).to eq(false)
    end

    it "パスワードが6文字以上であれば登録できる" do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      expect(@user).to be_valid
    end

    it "パスワードが5文字以下だと登録できない" do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      expect(@user).not_to be_valid
    end

    it "メールアドレスに大文字が混ざっていても登録できる" do
      @user.email = "AAA@EXAMPLe.com"
      expect(@user.valid?).to eq(true)
    end

    it "emailが正しく入力されているか" do
      @user.email = 'aaa@exam@le.com'
      expect(@user).not_to be_valid

      @user.email = 'aaaexample.com'
      expect(@user).not_to be_valid
    end

    it  "一意性が正しく機能しているか" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email
      @user.save!
      expect(duplicate_user).not_to be_valid
    end

    




  end
end