module UserEditMacros
  def visit_profile_edit
      visit new_user_session_path
      fill_in 'メールアドレス', with:'foo@example.com'
      fill_in 'パスワード', with: '123456'
      click_button 'ログイン'
      find('.dropdown-toggle').click
      click_link 'プロフィール編集'
    end
end