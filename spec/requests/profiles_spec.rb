require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @profile = FactoryBot.create(:profile)
    @sound = FactoryBot.create(:sound)
  end
  describe "コントローラーテスト" do
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
      it "ページの遷移確認" do
        get new_profile_path
        expect(response).to have_http_status(200)
      end
      it "ページのフォーム確認" do
        get edit_profile_path(@profile.id)
        expect(response.body).to include("profile[image]")
        expect(response.body).to include("profile[name]")
        expect(response.body).to include("profile[text]")
        expect(response.body).to include('type="submit"')
      end
    end
  end
end
