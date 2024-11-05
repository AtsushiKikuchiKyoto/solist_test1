require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @user = FactoryBot.create(:user)
    driven_by(:selenium_chrome_headless)
    # driven_by(:selenium_chrome)
  end
  describe "システムテスト" do

    # before action ユーザー登録
    before do
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_on 'submit'
      expect(page).to have_current_path(root_path)
    end
    # before action プロフィール作成
    before do
      find('#menu-icon').click
      expect(page).to have_content('新規プロフィール作成')
      click_on 'newProfile'
      expect(page).to have_current_path(new_profile_path)
      attach_file 'profile[image]', "#{Rails.root}/app/assets/images/avatar.jpg"
      fill_in 'name', with: 'AAA'
      fill_in 'text', with: 'aaaaaa'
      click_on 'submit'
      expect(page).to have_current_path(root_path)
      find('#avatar-icon').click
      expect(page).to have_content('AAA')
    end
    # before action サウンド作成
    before do
      find('#menu-icon').click
      click_on 'newSound'
      attach_file 'sound[sound]', "#{Rails.root}/spec/files/sound.m4a"
      fill_in 'text', with: 'aaaaaa'
      click_on 'submit'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('aaaaaa')
    end

    context "comment投稿機能" do
      it "テキストを入力し、削除" do
        first('.comment-hide').click
        fill_in 'text', with: 'bbbbbb'
        click_on 'submit'
        sleep 1
        expect(page).to have_current_path(root_path)
        first('.comment-hide').click
        expect(page).to have_content('bbbbbb')
        find('.comment-delete').click
        sleep 1
        expect(page).to have_current_path(root_path)
        first('.comment-hide').click
        expect(page).to have_no_content('bbbbbb')
      end
    end
  end
end
