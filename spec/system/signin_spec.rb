require 'rails_helper'

RSpec.describe 'Signin', type: :system do
  let!(:user) do
    create(:user,
           email: 'foo@example.com',
           name: 'Ben',
           password: '123456',
           password_confirmation: '123456')
  end

  it 'ログインページに遷移するか' do
    visit root_path
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
  end

  it '表示されるべき文字が表示されているか' do
    visit new_user_session_path
    expect(page).to have_link 'ログイン'
    expect(page).to have_link 'ゲストログイン'
    expect(page).to have_link '新規登録はこちら'
    expect(page).to have_link 'パスワードをお忘れですか？'
    expect(page).to have_link '確認メールを再送信'
  end

  it 'ログインできるか' do
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ログインしました'
  end

  it 'ゲストログインが機能しているか' do
    visit new_user_session_path
    click_link 'ゲストログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ゲストユーザーとしてログインしました。'
  end

  it '新規登録ページに遷移できるか' do
    visit new_user_session_path
    click_link '新規登録はこちら'
    expect(current_path).to eq new_user_registration_path
    expect(page).to have_content '新規登録'
  end

  it 'パスワード再設定の申請ページに遷移できるか' do
    visit new_user_session_path
    click_link 'パスワードをお忘れですか？'
    expect(current_path).to eq new_user_password_path
    expect(page).to have_content 'パスワード再設定の申請'
  end

  it '確認メール再送信ページに遷移できるか' do
    visit new_user_session_path
    click_link '確認メールを再送信'
    expect(current_path).to eq new_user_confirmation_path
    expect(page).to have_content '確認メールを再送信'
  end

  it '登録されていないユーザーが入力された場合エラーメッセージが表示されるか' do
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: '123'
    click_button 'ログイン'
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
  end
end
