require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile, user: @user)
    @sound = FactoryBot.create(:sound, profile: @profile)
    driven_by(:selenium_chrome_headless)
  end

  describe "ログインかつProfile選択状態テスト" do
    before do
      sign_in @user
      visit profiles_switch_path(@profile)
    end

    context "comment投稿機能" do
      it "コメントを作成し削除できる" do
        visit root_path
        expect {
          first('.comment-hide').click
          fill_in 'text', with: 'bbbbbb'
          click_on 'submit'
          sleep 1
        }.to change { @profile.comments.count }.by(1)
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('bbbbbb')
        find('.comment-delete').click
        page.accept_confirm
        sleep 1
        expect(page).to have_current_path(root_path)
        expect(page).to have_no_content('bbbbbb')
      end
    end
  end

  describe "ログインかつProfile選択なし状態テスト" do
    before do
      sign_in @user
    end

    context "comment閲覧機能" do
      it "コメントを閲覧できるが投稿フォームはなし" do
        visit root_path
        expect(page).to have_no_selector('.comment-box')
        first('.comment-hide').click
        expect(page).to have_selector('.comment-box')
        expect(page).to have_no_content('コメントを入力できます')
      end
    end
  end

  describe "ログアウト状態テスト" do
    context "comment閲覧できない" do
      it "ボタンもない" do
        visit root_path
        expect(page).to have_no_selector('.comment-hide')
      end
    end
  end
end
