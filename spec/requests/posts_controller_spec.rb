require 'rails_helper'

RSpec.describe PostsController, type: :request do
  before do
    @user = create(:user)
    @post = create(:post, user: @user)
  end

  describe '#index' do
    it '正常なレスポンスか' do
      get '/'
      expect(response).to be_successful
    end
    it '200レスポンスが返ってきているか' do
      get '/'
      expect(response).to have_http_status '200'
    end
    it '画像,タイトルが表示されているか' do
      get '/'
      expect(response.body).to include 'avocado-1838785_1920.jpg'
      expect(response.body).to include 'オムライス'
    end
  end

  describe '#show' do
    context '未ログインのとき' do
      it '302レスポンスが返って来ているか' do
        get '/posts/0'
        expect(response.status).to eq 302
      end
      it '正常にレスポンスが返って来ていないか' do
        get '/posts/0'
        expect(response).to_not be_successful
      end
      it 'ログインページにリダイレクトされるか' do
        get '/posts/0'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '200レスポンスが返って来ているか' do
        sign_in @user
        get '/posts/0'
        expect(response.status).to eq 200
      end
      it '正常なレスポンスか' do
        sign_in @user
        get '/posts/0'
        expect(response).to be_successful
      end
      it '画像,タイトル,キャプションが表示されているか' do
        sign_in @user
        get '/posts/0'
        expect(response.body).to include 'avocado-1838785_1920.jpg'
        expect(response.body).to include 'オムライス'
        expect(response.body).to include 'delicious'
      end
    end
  end

  describe '#new' do
    context '未ログインのとき' do
      it '302レスポンスが返って来ているか' do
        get '/new'
        expect(response.status).to eq 302
      end
      it '正常にレスポンスが返って来ていないか' do
        get '/new'
        expect(response).to_not be_successful
      end
      it 'ログインページにリダイレクトされるか' do
        get '/new'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '200レスポンスが返って来ているか' do
        sign_in @user
        get '/new'
        expect(response.status).to eq 200
      end
      it '正常なレスポンスか' do
        sign_in @user
        get '/new'
        expect(response).to be_successful
      end
    end
  end

  # #createは未ログインユーザーはたどり着けないので未ログイン状態でのテスト不要
  describe '#create' do
    context '投稿に成功した場合' do
      it '正常に投稿できているか' do
        sign_in @user
        expect do
          post '/', params: { post: attributes_for(:post) }
        end.to change(@user.posts, :count).by(1)
      end
      it '投稿後トップページにリダイレクトするか' do
        sign_in @user
        post '/', params: { post: attributes_for(:post) }
        expect(response).to redirect_to '/'
      end
    end
    context '投稿に失敗した場合(パラメータが不正)' do
      it '投稿されていないか' do
        sign_in @user
        expect do
          post '/', params: { post: attributes_for(:post, img: '') }
        end.not_to change(@user.posts, :count)
      end
      it 'リクエストが成功するか' do
        sign_in @user
        post '/', params: { post: attributes_for(:post, img: '') }
        expect(response.status).to eq 200
      end
      it 'エラーが表示されるか' do
        sign_in @user
        post '/', params: { post: attributes_for(:post, title: '') }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end

  describe '#edit' do
    context '未ログイン状態のとき' do
      it '302レスポンスが返って来ているか' do
        get '/posts/0/edit'
        expect(response.status).to eq 302
      end
      it '正常にレスポンスが返って来ていないか' do
        get '/posts/0/edit'
        expect(response).to_not be_successful
      end
      it 'ログインページにリダイレクトされるか' do
        get '/posts/0/edit'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログイン状態のとき' do
      it '200レスポンスが返って来ているか' do
        sign_in @user
        get '/posts/0/edit'
        expect(response.status).to eq 200
      end
      it '正常なレスポンスか' do
        sign_in @user
        get '/posts/0/edit'
        expect(response).to be_successful
      end
      it 'タイトル,キャプション,URLが表示されていること' do
        sign_in @user
        get '/posts/0/edit'
        expect(response.body).to include 'オムライス'
        expect(response.body).to include 'https://example.com'
        expect(response.body).to include 'delicious'
      end
    end
    context '投稿者とログインユーザーが異なるとき(直接URLを入力し、編集ページにアクセスした場合)' do
      it 'トップページにリダイレクトされるか' do
        another_user = create(:user)
        sign_in another_user
        get '/posts/0/edit'
        expect(response).to redirect_to '/'
      end
    end
  end

  # #updateは未ログインユーザーはたどり着けないので未ログイン状態でのテスト不要
  describe '#update' do
    context 'パラメータが妥当な場合' do
      it '正常に記事を更新できているか' do
        sign_in @user
        patch '/posts/0/update', params: { post: attributes_for(:post, title: 'ハンバーグ') }
        expect(@post.reload.title).to eq 'ハンバーグ'
      end
      it '正常に記事を更新できているか(更新前の名前と異なるか)' do
        sign_in @user
        patch '/posts/0/update', params: { post: attributes_for(:post, title: 'ハンバーグ') }
        expect(@post.reload.title).not_to eq 'オムライス'
      end
      it '更新後トップページにリダイレクトするか' do
        sign_in @user
        patch '/posts/0/update', params: { post: attributes_for(:post) }
        expect(response).to redirect_to '/'
      end
    end
    context ' パラメータが不正な場合' do
      it 'titleが更新されていないか' do
        sign_in @user
        patch '/posts/0/update', params: { post: attributes_for(:post, title: '') }
        expect(@post.reload.title).not_to eq ''
      end
      it 'titleが更新前の値になっているか' do
        sign_in @user
        patch '/posts/0/update', params: { post: attributes_for(:post, title: '') }
        expect(@post.reload.title).to eq 'オムライス'
      end
      it 'リクエストが成功するかか' do
        sign_in @user
        patch '/posts/0/update', params: { post: attributes_for(:post, title: '') }
        expect(response.status).to eq 200
      end
      it 'エラーが表示されるか' do
        sign_in @user
        patch '/posts/0/update', params: { post: attributes_for(:post, title: '') }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end

  # #destroyは未ログインユーザー,他のユーザーはたどり着けないので未ログイン状態,他のユーザーのテスト不要
  describe '#destroy' do
    it 'リクエストが成功するか' do
      delete '/posts/0'
      expect(response.status).to eq 302
    end
    it '正常に記事を削除できるか' do
      sign_in @user
      expect do
        delete '/posts/0'
      end.to change(@user.posts, :count).by(-1)
    end
    it '削除後トップページにリダイレクトするか' do
      sign_in @user
      delete '/posts/0'
      expect(response).to redirect_to '/'
    end
  end
end
