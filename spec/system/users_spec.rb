require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @user2 = FactoryBot.create(:user)
    driven_by(:selenium_chrome_headless)
  end
  describe "システムテスト" do
    context "user登録できるとき" do
      it "正しい情報を入力" do
        visit new_user_registration_path
        expect(page).to have_content('新規登録')
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        fill_in 'password_confirmation', with: @user.password_confirmation
        expect{ 
          click_on 'submit'
          sleep 1
         }.to change { User.count }.by(1)
        expect(page).to have_current_path(root_path)
      end
    end

    context "user登録できないとき" do
      it "誤った情報入力によりページに戻ってくる" do
        visit new_user_registration_path
        expect(page).to have_content('新規登録')
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        fill_in 'password_confirmation', with: ''
        expect{ 
          click_on 'submit'
          sleep 1
         }.to change { User.count }.by(0)
        expect(page).to have_current_path(new_user_registration_path)
      end
    end

    context "ログインできるとき" do
      it "正しい情報を入力" do
        visit new_user_session_path
        expect(page).to have_content('ログイン')
        fill_in 'email', with: @user2.email
        fill_in 'password', with: @user2.password
        click_on 'submit'
        expect(page).to have_current_path(root_path)
      end
    end

    context "ログインできないとき" do
      it "誤った情報入力によりページに戻ってくる" do
        visit new_user_session_path
        expect(page).to have_content('ログイン')
        fill_in 'email', with: @user2.email
        fill_in 'password', with: ''
        click_on 'submit'
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    context "ユーザー削除機能" do
      it "退会ページへ遷移し、ユーザー削除" do
        sign_in @user
        visit root_path
        find('#menu-icon').click
        expect(page).to have_link('退会', href: '/finish')
        click_on 'finish'
        expect(page).to have_current_path('/finish')
        expect{ 
          click_on 'submit'
          sleep 1
         }.to change { User.count }.by(-1)
         expect(page).to have_current_path(root_path)
      end
    end

  end
end
