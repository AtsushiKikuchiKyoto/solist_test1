require 'rails_helper'

RSpec.describe "Sounds", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @profile = FactoryBot.create(:profile)
    @sound = FactoryBot.create(:sound)
  end
  describe "コントローラーテスト" do
    context "newアクション" do
      it "ページの遷移確認" do
      end
    end
  end
end
