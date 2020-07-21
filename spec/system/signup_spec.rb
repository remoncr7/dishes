require 'rails_helper'

RSpec.describe 'Signup', type: :system do
    let!(:user) do
      create(:user,
        email: 'foo@example.com',
        name: 'Ben', 
        password: '123456',
        password_confirmation: '123456'
      )
  end

  it '新規登録ページに遷移するか' do 
    visit root_path
    click_link '新規登録'
    expect(current_path).to eq new_user_registration_path
  end
  
  it '表示されるべき文字が表示されているか' do 
    visit new_user_registration_path
    expect(page).to have_link '新規登録'
    expect(page).to have_link 'ゲストログイン'
    expect(page).to have_link 'すでにアカウントをお持ちですか？(ログイン)'
    expect(page).to have_link '確認メールを再送信'
  end

  it '新規登録できるか(本人確認用のメールが送信されるか)' do
    visit new_user_registration_path
    fill_in 'ニックネーム', with:'Ben'
    fill_in 'メールアドレス', with:'aaa@example.com'
    fill_in 'パスワード', with: '123456'
    fill_in 'パスワード（再入力）', with: '123456'
    click_button 'アカウントを作成する'
    expect(current_path).to eq root_path
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。' 
  end
  
  it 'ゲストログインが機能しているか' do 
    visit new_user_registration_path
    click_link 'ゲストログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ゲストユーザーとしてログインしました。' 
  end

  it 'ログインページに遷移できるか' do 
    visit new_user_registration_path
    click_link 'すでにアカウントをお持ちですか？(ログイン)'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'ログイン' 
  end

  it '確認メール再送信ページに遷移できるか' do 
    visit new_user_registration_path
    click_link '確認メールを再送信'
    expect(current_path).to eq new_user_confirmation_path
    expect(page).to have_content '確認メールを再送信' 
  end

  context '不正な値が入力された場合' do
    it 'バリデーションのエラーメッセージが表示されるか' do
      visit new_user_registration_path
      fill_in 'ニックネーム', with: '1234567890123456' 
      fill_in 'メールアドレス', with:'bbb@example.com'
      fill_in 'パスワード', with: '12345'
      fill_in 'パスワード（再入力）', with: '12345'
      click_button 'アカウントを作成する'
      # expect(current_path).to eq new_user_registration_path
      expect(page).to have_content 'ニックネームは15文字以内で入力してください' 
      expect(page).to have_content 'パスワードは6文字以上で入力してください' 
    end
    it 'フォームに入力されなかった場合にエラーメッセージが表示されるか' do
      visit new_user_registration_path
      fill_in 'ニックネーム', with: '' 
      fill_in 'メールアドレス', with:''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（再入力）', with: ''
      click_button 'アカウントを作成する'
      expect(page).to have_content 'メールアドレスを入力してください' 
      expect(page).to have_content 'パスワードを入力してください' 
      expect(page).to have_content 'パスワードを入力してください' 
    end
  end




end