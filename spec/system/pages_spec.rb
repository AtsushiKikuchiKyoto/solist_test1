require 'rails_helper'

RSpec.describe "Pages", type: :system do

  before do
    driven_by(:selenium_chrome_headless)
    # driven_by(:selenium_chrome)
  end

  describe "システムテスト" do
    context "4ページへの遷移確認" do
      it "ログインせずに、メニューアイコンから各ページへ遷移" do
        visit root_path
        find('#menu-icon').click
        expect(page).to have_content('リンクス')
        click_on 'toLinks'
        expect(page).to have_current_path('/links')
        expect(page).to have_link('このアプリ、Solistについて', href: '/about')
        expect(page).to have_link('このアプリの使い方について', href: '/howto')
        expect(page).to have_link('開発者の自己紹介', href: '/developer')
      end
    end
  end
end
