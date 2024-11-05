require 'rails_helper'

RSpec.describe "Sounds", type: :system do
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

    context "sound作成機能" do
      it "正しい情報を入力(rootへ遷移)" do
        find('#menu-icon').click
        expect(page).to have_content('サウンドの新規投稿')
        click_on 'newSound'
        expect(page).to have_current_path(new_sound_path)
        attach_file 'sound[sound]', "#{Rails.root}/spec/files/sound.m4a"
        fill_in 'text', with: 'aaaaaa'
        click_on 'submit'
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('aaaaaa')
      end
      it "間違った情報を入力(ページとどまる)" do
        find('#menu-icon').click
        expect(page).to have_content('サウンドの新規投稿')
        click_on 'newSound'
        expect(page).to have_current_path(new_sound_path)
        attach_file 'sound[sound]', "#{Rails.root}/spec/files/sound.m4a"
        fill_in 'text', with: ''
        click_on 'submit'
        expect(page).to have_current_path(new_sound_path)
      end
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
    context "sound編集機能" do
      it "正しい情報を入力(rootへ遷移)" do
        expect(page).to have_current_path(root_path)
        click_on "editSound"
        expect(page).to have_content('編集する')
        fill_in 'text', with: 'bbbbbb'
        click_on 'submit'
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('bbbbbb')
      end
      it "間違った情報を入力(ページとどまる)" do
        expect(page).to have_current_path(root_path)
        click_on "editSound"
        expect(page).to have_content('編集する')
        fill_in 'text', with: ''
        click_on 'submit'
        expect(page).to have_content('編集する')
      end
    end
    context "sound削除機能" do
      it "正常に削除できる(rootへ遷移)" do
        expect(page).to have_current_path(root_path)
        expect{ 
          click_on "deleteSound"
          sleep 1
         }.to change { Sound.count }.by(-1)
        expect(page).to have_current_path(root_path)
      end
    end
    context "profile詳細表示機能" do
      it "正常に表示される" do
        expect(page).to have_current_path(root_path)
        click_on "showProfile"
        expect(page).to have_content('プロフィール')
      end
    end
  end
end
