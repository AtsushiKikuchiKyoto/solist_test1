require 'rails_helper'

RSpec.describe "Profiles", type: :system do
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

    context "profile作成機能" do
      it "正しい情報を入力(rootへ遷移)" do
        find('#menu-icon').click
        expect(page).to have_content('新規プロフィール作成')
        click_on 'newProfile'
        expect(page).to have_current_path(new_profile_path)
        attach_file 'profile[image]', "#{Rails.root}/app/assets/images/avatar.jpg"
        fill_in 'name', with: 'AAA'
        fill_in 'text', with: 'aaaaaa'
        expect{ 
          click_on 'submit'
          sleep 1
         }.to change { Profile.count }.by(1)
        expect(page).to have_current_path(root_path)
        find('#avatar-icon').click
        expect(page).to have_content('AAA')
      end
      it "間違った情報を入力(ページにとどまる)" do
        find('#menu-icon').click
        expect(page).to have_content('新規プロフィール作成')
        click_on 'newProfile'
        expect(page).to have_current_path(new_profile_path)
        attach_file 'profile[image]', "#{Rails.root}/app/assets/images/avatar.jpg"
        fill_in 'name', with: 'AAA'
        fill_in 'text', with: ''
        expect{ 
          click_on 'submit'
          sleep 1
         }.to change { Profile.count }.by(0)
        expect(page).to have_current_path(new_profile_path)
      end
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
    
    context "profile編集機能" do
      it "詳細ページへ遷移し編集ができる" do
        find('#menu-icon').click
        expect(page).to have_content('プロフィールの編集')
        click_on 'editProfile'
        expect(page).to have_content('プロフィールを編集')
        fill_in 'name', with: 'BBB'
        click_on 'submit'
        expect(page).to have_current_path(root_path)
        find('#avatar-icon').click
        expect(page).to have_content('BBB')  
      end
      it "詳細ページへ遷移し編集ができずページにとどまる" do
        find('#menu-icon').click
        expect(page).to have_content('プロフィールの編集')
        click_on 'editProfile'
        expect(page).to have_content('プロフィールを編集')
        fill_in 'name', with: ''
        click_on 'submit'
        expect(page).to have_content('プロフィールを編集')
      end
    end
    context "profile削除機能" do
      it "プロフィール削除ができる" do
        find('#menu-icon').click
        expect(page).to have_content('プロフィールの削除')
        expect{ 
          click_on 'deleteProfile'
          page.accept_confirm
          sleep 1
         }.to change { Profile.count }.by(-1)
        expect(page).to have_current_path(root_path)
      end
    end
  end

end
