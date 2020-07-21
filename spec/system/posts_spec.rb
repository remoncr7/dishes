require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before do 
    @user = create(:user)
  end

  it 'OK?' do 
    visit root_path(@user)
    expect(page).to have_content '投稿一覧'
  end

  

  




end