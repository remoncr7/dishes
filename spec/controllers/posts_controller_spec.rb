require 'rails_helper'

RSpec.describe PostsController, type: :request do

  before do 
    @user = create(:user)
    @post = create(:post)
  end


  describe "#index" do
    it "正常なレスポンスか" do
      get '/'
      expect(response).to be_successful
    end
    it "200レスポンスが返ってきているか" do
      get '/'
      expect(response).to have_http_status "200"
    end
    it '画像,タイトルが表示されているか' do
      get '/'
      expect(response.body).to include "avocado-1838785_1920.jpg"
      expect(response.body).to include "オムライス"
    end
  end


  describe "#show" do
    context '未ログインのとき' do
      it 'ログインページにリダイレクトされるか' do
        get '/posts/0'
        expect(response.status).to eq 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context 'ログイン状態のとき' do
      it "正常なレスポンスか" do
        sign_in @user
        get '/posts/0'
        expect(response.status).to eq 200
        expect(response).to be_successful
      end
      it '画像,タイトル,キャプションが表示されているか' do
        sign_in @user
        get '/posts/0'
        expect(response.body).to include "avocado-1838785_1920.jpg"
        expect(response.body).to include "オムライス"
        expect(response.body).to include "delicious"
      end
    end
  end

  
  describe '#new' do
    context '未ログインのとき' do
      it 'ログインページにリダイレクトされるか' do
        get '/new'
        expect(response.status).to eq 302
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context 'ログイン状態のとき' do
      it "正常なレスポンスか" do
        sign_in @user
        get '/new'
        expect(response.status).to eq 200
        expect(response).to be_successful
      end
    end
  end


end 