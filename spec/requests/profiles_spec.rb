require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile)
    @sound = FactoryBot.create(:sound)
    @another_user = FactoryBot.create(:user)
    @another_user_profile = FactoryBot.create(:profile, user: @another_user)
  end

  describe "ログイン状態のテスト" do
    before do
      sign_in @user
    end

    context "indexアクション" do
      it "ページの遷移確認" do
        get root_path
        expect(response).to have_http_status(200)
      end
      it "ページのsound表示確認" do
        get root_path
        expect(response.body).to include(@sound.text)
      end
    end

    context "newアクション" do
      it "ページの遷移確認" do
        get new_profile_path
        expect(response).to have_http_status(200)
      end
      it "ページのフォーム確認" do
        get new_profile_path
        expect(response.body).to include("profile[image]")
        expect(response.body).to include("profile[name]")
        expect(response.body).to include("profile[text]")
        expect(response.body).to include('type="submit"')
      end
    end
    
    context "editアクション" do
      it "プロフィール選択時、ページの遷移確認" do
        get profiles_switch_path(@profile)
        get edit_profile_path(@profile)
        expect(response).to have_http_status(200)
      end
      it "プロフィール未選択、ページの遷移できない" do
        get edit_profile_path(@profile)
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("プロフィールを作成し選択してください。")
      end
      it "プロフィール選択時、ページのフォーム確認" do
        get profiles_switch_path(@profile)
        get edit_profile_path(@profile)
        expect(response.body).to include("profile[image]")
        expect(response.body).to include("profile[name]")
        expect(response.body).to include("profile[text]")
        expect(response.body).to include('type="submit"')
      end
      it "他ユーザーのプロフィール編集ページへ遷移できない" do
        get profiles_switch_path(@profile)
        get edit_profile_path(@another_user_profile)
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("プロフィールが異なります。")
      end
    end

    context "showアクション" do
      it "ページの遷移確認" do
        get profile_path(@profile)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "ログアウト状態のテスト" do
    context "newアクション" do
      it "ページの遷移できない" do
        get new_profile_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "editアクション" do
      it "ページの遷移できない" do
        get edit_profile_path(@profile)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "showアクション" do
      it "ページの遷移できない" do
        get profile_path(@profile)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
