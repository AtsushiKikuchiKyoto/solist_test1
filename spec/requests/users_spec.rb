require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "GET /users/sign_in" do
    it "returns http success" do
      get "/users/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /users/sign_up" do
    it "returns http success" do
      get "/users/sign_up"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /users" do
    it "returns http success" do
      sign_in @user
      delete user_registration_path
      expect(response).to redirect_to(root_path)
    end
  end
end
