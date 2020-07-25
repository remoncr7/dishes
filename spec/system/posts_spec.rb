require 'rails_helper'

RSpec.describe 'Signup', type: :system do
  let!(:user) do
    create(:user,
           email: 'foo@example.com',
           name: 'Ben',
           password: '123456',
           password_confirmation: '123456')
  end

  #  login_post: ログイン後、投稿する
  it 'トップページでタイトルとユーザー名が表示されるか' do
    login_post
    expect(current_path).to eq root_path
    expect(page).to have_content 'Ben'
    expect(page).to have_content '肉じゃが'
    expect(page).to have_selector '.far'
  end

  it '投稿詳細ページで投稿の情報が表示されるか' do
    login_post
    find('.post__elements').click
    expect(page).to have_content 'great!'
    expect(page).to have_content 'Ben'
    expect(page).to have_content '肉じゃが'
    expect(page).to have_link '参考にしたレシピはこちら'
  end

  it '投稿詳細ページでいいね機能が正常に機能しているか' do
    login_post
    find('.post__elements').click
    expect(page).to have_selector '.far'
    find('.fa-heart').click
    expect(page).to have_selector '.fas'
    find('.fa-heart').click
    expect(page).to have_selector '.far'
  end

  it 'MyPostに表示されるか' do
    login_post
    click_link 'MyPost'
    expect(current_path).to eq my_post_path
    expect(page).to have_content '肉じゃが'
    expect(page).to have_link 'レシピはこちら'
  end
  it '投稿を更新できるか' do
    login_post
    find('.post__elements').click
    find('.post__edit').click
    expect(page).to have_content '編集する'
    fill_in 'タイトル', with: 'カレー'
    fill_in 'キャプション', with: '美味しい'
    click_button '更新'
    expect(current_path).to eq root_path
    expect(page).to have_content 'カレー'
  end

  it 'いいねした投稿一覧ページに遷移できるか' do
    login_post
    find('.dropdown-toggle').click
    click_link 'いいね'
    expect(page).to have_content 'いいねした投稿'
    expect(current_path).to eq like_path
  end
  
  it 'MyPostページに遷移できるか' do
    login_post
    find('.dropdown-toggle').click
    find('.fa-folder-open').click
    expect(page).to have_content 'MyPost'
    expect(current_path).to eq my_post_path
  end
end
