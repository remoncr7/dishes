require 'rails_helper'

RSpec.describe 'User', type: :system do
    let!(:user) do
      create(:user,
        name: 'Ben', 
        email: 'foo@example.com',
        password: '123456',
        password_confirmation: '123456'
      )
  end

  it '表示されるべき文字が表示されているか' do 
    visit_profile_edit
    expect(page).to have_content 'プロフィール編集'
    expect(page).to have_link 'ログアウト'
    expect(page).to have_link 'アカウント削除'
    expect(page).to have_link '戻る'
  end

  it 'プロフィール編集ができているか' do
    visit_profile_edit
    fill_in 'ニックネーム', with:'Tom'
    fill_in 'メールアドレス', with:'foo@example.com'
    fill_in 'パスワード', with: 'abcdef'
    fill_in 'パスワード（再入力）', with: 'abcdef'
    fill_in '現在のパスワード', with: '123456'
    click_button '更新'
    expect(current_path).to eq root_path
    expect(page).to have_content 'アカウント情報を変更しました。' 
  end
  
  # visit_profile_edit: ログイン後プロフィール変更ページに遷移
  it 'ログアウトできるか' do 
    visit_profile_edit
    click_link 'ログアウト'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ログアウトしました。' 
  end

  it '戻るが機能しているか' do 
    visit_profile_edit
    click_link '戻る'
    expect(current_path).to eq root_path
  end

  it 'アカウント削除をキャンセルできるか' do 
    visit_profile_edit
    click_link 'アカウント削除'
    expect(page.dismiss_confirm).to eq "本当にアカウントを削除しますか？"
    expect(current_path).to eq edit_user_registration_path
    expect(page).to have_content 'プロフィール編集'
  end
  
  it 'アカウント削除できるか' do 
    visit_profile_edit
    click_link 'アカウント削除'
    expect(page.accept_confirm).to eq "本当にアカウントを削除しますか？"
    expect(current_path).to eq root_path
    expect(page).to have_content '投稿一覧'
  end


  context '不正な値が入力された場合' do
    it 'バリデーションのエラーメッセージが表示されるか' do
      visit_profile_edit
      fill_in 'ニックネーム', with: '1234567890123456' 
      fill_in 'メールアドレス', with:'foo@example.com'
      fill_in 'パスワード', with: '12345'
      fill_in 'パスワード（再入力）', with: '12345'
      click_button '更新'
      # expect(current_path).to eq edit_user_registration_path
      expect(page).to have_content 'ニックネームは15文字以内で入力してください' 
      expect(page).to have_content 'パスワードは6文字以上で入力してください' 
    end
    it 'フォームに入力されなかった場合にエラーメッセージが表示されるか' do
      visit_profile_edit
      fill_in 'ニックネーム', with: '' 
      fill_in 'メールアドレス', with:''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（再入力）', with: ''
      click_button '更新'
      expect(page).to have_content 'メールアドレスを入力してください' 
      expect(page).to have_content 'パスワードを入力してください' 
      expect(page).to have_content 'パスワードを入力してください' 
    end
  end

  it 'ゲストユーザーはプロフィール編集できないか' do
    visit new_user_session_path
    click_link 'ゲストログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ゲストユーザーとしてログインしました。'
    find('.dropdown-toggle').click
    click_link 'プロフィール編集'
    fill_in 'ニックネーム', with: '1234' 
    click_button '更新' 
    expect(current_path).to eq root_path
    expect(page).to have_content 'ゲストユーザーの変更・削除はできません。'
  end
  
  it 'ゲストユーザーはアカウント削除できないか' do
    visit new_user_session_path
    click_link 'ゲストログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content 'ゲストユーザーとしてログインしました。'
    find('.dropdown-toggle').click
    click_link 'プロフィール編集'
    click_link 'アカウント削除' 
    expect(page.accept_confirm).to eq "本当にアカウントを削除しますか？"
    expect(current_path).to eq root_path
    expect(page).to have_content 'ゲストユーザーの変更・削除はできません。'
  end



end