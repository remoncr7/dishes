module PostMacros
  def login_post
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'foo@example.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content '投稿一覧'
    # 投稿ページに遷移できるか
    click_link '投稿'
    expect(page).to have_content '投稿する'
    # 投稿
    attach_file 'post[img]', "#{Rails.root}/spec/fixtures/avocado-1838785_1920.jpg", make_visible: true
    fill_in 'タイトル', with: '肉じゃが'
    fill_in 'キャプション', with: 'great!'
    fill_in '参考にしたレシピのURL', with: 'https://example.com'
    click_button '投稿'
  end
end
