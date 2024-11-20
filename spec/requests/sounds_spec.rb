require 'rails_helper'

RSpec.describe "Sounds", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile)
    @sound = FactoryBot.create(:sound)
  end
  describe "ログイン状態のテスト" do
    before do
      sign_in @user
    end

    context "newアクション" do
      it "ページの遷移確認" do
        get profiles_switch_path(@profile.id)
        get new_sound_path
        expect(response).to have_http_status(200)
      end
    end

    context "editアクション" do
      it "ページの遷移確認" do
        get profiles_switch_path(@profile.id)
        get edit_sound_path(@sound.id)
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "ログインアウト状態のテスト" do
    context "newアクション" do
      it "ページの遷移できない" do
        get new_sound_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "editアクション" do
      it "ページの遷移できない" do
        get edit_sound_path(@sound.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  describe "プロフィール未選択状態のテスト" do
    before do
      sign_in @user
    end
    context "newアクション" do
      it "ページの遷移できない" do
        get new_sound_path
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("プロフィールを作成し選択してください。")
      end
    end

    context "editアクション" do
      it "ページの遷移できない" do
        get edit_sound_path(@sound.id)
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("プロフィールを作成し選択してください。")
      end
    end
  end
end
