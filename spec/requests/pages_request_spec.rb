require 'rails_helper'

RSpec.describe "Pages", type: :request do

  describe "GET /links" do
    it "returns http success" do
      get "/pages/links"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/pages/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /howto" do
    it "returns http success" do
      get "/pages/howto"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /developer" do
    it "returns http success" do
      get "/pages/developer"
      expect(response).to have_http_status(:success)
    end
  end

end
