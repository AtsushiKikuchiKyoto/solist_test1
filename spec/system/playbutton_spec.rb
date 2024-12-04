require 'rails_helper'

RSpec.describe "Pages", type: :system do

  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile, user: @user)
    @sound1 = FactoryBot.create(:sound, profile: @profile)
    @sound2 = FactoryBot.create(:sound, profile: @profile)
    @sound3 = FactoryBot.create(:sound, profile: @profile)
    # driven_by(:selenium_chrome_headless)
  end

  describe "ボタンカラー" do
    before do
      visit root_path
    end

    context "初期状態の確認" do
      it "プレイボタンはグレー" do
        expect(page).to have_selector('.grayscale')
      end
    end

    context "プレイボタンからの操作" do
      it "プレイボタンを押すとカラーがつく" do
        find('#play-button').click
        sleep 1
        expect(page).to have_selector('.colorful')
      end
      
      it "プレイボタンで再生を止めるとグレーに戻る" do
        find('#play-button').click
        sleep 1
        find('#play-button').click
        sleep 1
        expect(page).to have_selector('.grayscale')
      end
    end
  end

  describe "再生機能の確認" do
    before do
      visit root_path
    end
  end
end
