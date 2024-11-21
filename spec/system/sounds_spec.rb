require 'rails_helper'

RSpec.describe "Sounds", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @profile = FactoryBot.create(:profile, user: @user)
    @sound = FactoryBot.create(:sound, profile: @profile)
    @user2 = FactoryBot.create(:user)
    @profile2 = FactoryBot.create(:profile, user: @user2)
    @sound2 = FactoryBot.create(:sound, profile: @profile2)
    driven_by(:selenium_chrome_headless)
  end

  describe "ログインかつProfile選択状態テスト" do
    before do
      sign_in @user
      visit profiles_switch_path(@profile)
    end

    context "Newアクション" do
      it "SoundNewページへの遷移" do
        visit root_path
        find('#menu-icon').click
        expect(page).to have_content('サウンドの新規投稿')
        click_on 'newSound'
        expect(page).to have_current_path(new_sound_path)
      end

      it "正しい情報を入力(rootへ遷移)" do
        visit new_sound_path
        expect{ 
          attach_file 'sound[sound]', "#{Rails.root}/spec/files/sound.m4a"
          fill_in 'text', with: 'aaaaaa'
          click_on 'submit'
          sleep 1
         }.to change { @profile.sounds.count }.by(1)
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('aaaaaa')
        expect(page).to have_content("サウンドを作成しました。")
      end
      
      it "間違った情報を入力(ページとどまる)" do
        visit new_sound_path
        expect{ 
          attach_file 'sound[sound]', "#{Rails.root}/spec/files/sound.m4a"
          fill_in 'text', with: ''
          click_on 'submit'
          sleep 1
         }.to change { @profile.sounds.count }.by(0)
        expect(page).to have_current_path(new_sound_path)
      end
    end

    context "Editアクション" do
      it "SoundEditページへの遷移" do
        visit root_path
        click_on "editSound"
        expect(page).to have_content('編集する')
        expect(page).to have_current_path(edit_sound_path(@sound))
      end

      it "Soundの正しい編集" do
        visit edit_sound_path(@sound)
        fill_in 'text', with: 'bbbbbb'
        click_on 'submit'
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('サウンドを編集しました。')
        expect(page).to have_content('bbbbbb')
      end

      it "Soundの間違った編集" do
        visit edit_sound_path(@sound)
        fill_in 'text', with: ''
        click_on 'submit'
        expect(page).to have_current_path(edit_sound_path(@sound))
        expect(page).to have_content('タイトル・説明文を入力してください')
      end

      it "他のユーザーのSoundEditページへの遷移不可" do
        visit edit_sound_path(@sound2)
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('別のユーザーのサウンドです。')
      end
    end

    context "Destroyアクション" do
      it "正常に削除できる(rootへ遷移)" do
        expect(page).to have_current_path(root_path)
        expect{ 
          click_on "deleteSound"
          page.accept_confirm
          sleep 1
         }.to change { Sound.count }.by(-1)
        expect(page).to have_current_path(root_path)
      end
    end
  end

  describe "ログインかつProfileなし状態テスト" do
    before do
      sign_in @user
    end

    context "Newアクション" do
      it "SoundNewページへの遷移できない" do
        visit root_path
        find('#menu-icon').click
        expect(page).to have_no_content('サウンドの新規投稿')
        visit new_sound_path
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('プロフィールを作成し選択してください。')
      end
    end

    context "Editアクション" do
      it "自分のSoundのEditページへ遷移できる" do
        visit root_path
        click_on "editSound"
        expect(page).to have_content('編集する')
        expect(page).to have_current_path(edit_sound_path(@sound))
      end

      it "自分のSoundを編集できる" do
        visit edit_sound_path(@sound)
        fill_in 'text', with: 'bbbbbb'
        click_on 'submit'
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('サウンドを編集しました。')
        expect(page).to have_content('bbbbbb')
      end

      it "他人のSound編集ページへ遷移できない" do
        visit edit_sound_path(@sound2)
        expect(page).to have_current_path(root_path)
        expect(page).to have_content('別のユーザーのサウンドです。')
      end
    end
  end

  describe "ログアウト状態テスト" do
    context "Newアクション" do
      it "SoundNewページへの遷移できない" do
        visit new_sound_path
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    context "Editアクション" do
      it "SoundEditページへの遷移できない" do
        visit edit_sound_path(@sound)
        expect(page).to have_current_path(new_user_session_path)
      end
    end
  end
end
