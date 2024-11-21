require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile, user: @user)
    driven_by(:selenium_chrome_headless)
  end
  describe "ログイン状態テスト" do
    before do
      sign_in @user
    end

    context "profile作成機能" do
      it "newProfileページへの遷移" do
        visit root_path
        find('#menu-icon').click
        expect(page).to have_content('新規プロフィール作成')
        click_on 'newProfile'
        expect(page).to have_current_path(new_profile_path)
      end

      it "正しい情報を入力(rootへ遷移)" do
        visit new_profile_path
        attach_file 'profile[image]', "#{Rails.root}/app/assets/images/avatar.jpg"
        fill_in 'name', with: 'AAA'
        fill_in 'text', with: 'aaaaaa'
        expect{ 
          click_on 'submit'
          sleep 1
         }.to change { @user.profiles.count }.by(1)
        expect(page).to have_current_path(root_path)
        expect(page).to have_content("プロフィールが作成されました。アバターアイコンから選択可能です。")
        find('#avatar-icon').click
        expect(page).to have_content('AAA')
      end
      
      it "間違った情報を入力(ページにとどまる)" do
        visit new_profile_path
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
  end

  describe "プロフィール作成後テスト" do
    before do
      sign_in @user
      visit profiles_switch_path(@profile)
    end
    
    context "profile編集機能" do
      it "プロフィールの編集ページへ遷移できる" do
        visit root_path
        find('#menu-icon').click
        expect(page).to have_content('プロフィールの編集')
        click_on 'editProfile'
        expect(page).to have_content('プロフィールを編集')
      end

      it "プロフィールの編集ができる" do
        visit edit_profile_path(@profile)
        expect(page).to have_content('プロフィールを編集')
        fill_in 'name', with: 'BBB'
        click_on 'submit'
        expect(page).to have_current_path(root_path)
        expect(page).to have_content("プロフィールを編集しました。")
        find('#avatar-icon').click
        expect(page).to have_content('BBB')  
      end

      it "入力不足でプロフィールの編集ができない" do
        visit edit_profile_path(@profile)
        expect(page).to have_content('プロフィールを編集')
        fill_in 'name', with: ''
        click_on 'submit'
        expect(page).to have_content('プロフィールを編集')
      end
    end

    context "profile削除機能" do
      before do
        sign_in @user
        visit profiles_switch_path(@profile)
      end

      it "プロフィール削除ができる" do
        visit root_path
        find('#menu-icon').click
        expect(page).to have_content('プロフィールの削除')
        expect{ 
          click_on 'deleteProfile'
          page.accept_confirm
          sleep 1
         }.to change { @user.profiles.count }.by(-1)
        expect(page).to have_current_path(root_path)
      end
    end
  end

end
