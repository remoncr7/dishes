require 'rails_helper'

RSpec.describe User, type: :model do
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
      @user.password = @user.password_confirmation = 'a' * 6 
      expect(@user.valid?).to eq(true)

      @user.password = @user.password_confirmation = ' ' * 6 
      expect(@user.valid?).to eq(false)
    end

    describe 'passward length' do
      context 'パスワードが6桁のとき' do 
        it "登録できる" do
          @user.password = @user.password_confirmation = '123456'
          expect(@user).to be_valid
        end
      end

      context 'パスワードが5文字のとき' do 
        it "登録できない" do
          @user.password = @user.password_confirmation = '12345'
          expect(@user).not_to be_valid
        end
      end
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

    it  "emailの一意性が正しく機能しているか" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email
      @user.save!
      expect(duplicate_user).not_to be_valid
    end

    it "大文字が混ざって登録されたemailをリロードしたものは、小文字のemailと一致するか" do
      @user.email = 'AAA@exAMPLE.com'
      @user.save!
      expect(@user.reload.email).to eq 'aaa@example.com'
    end

    it "パスワードと確認パスワードが一致するか" do
      expect(@user.password).to eq @user.password_confirmation
    end

    




  end
end