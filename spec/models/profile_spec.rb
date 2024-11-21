require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @profile = FactoryBot.build(:profile)
  end
  describe 'profile新規作成' do
    context "作成できるとき" do
      it 'すべての項目が正常に入力される' do
        @profile.valid?
        expect(@profile).to be_valid
      end
    end
    context "作成できないとき" do
      it 'nameが空の時' do
        @profile.name = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include "名前を入力してください"
      end
      it 'textが空の時' do
        @profile.text = ""
        @profile.valid?
        expect(@profile.errors.full_messages).to include "紹介文を入力してください"
      end
      it '画像が空の時' do
        @profile.image = nil
        @profile.valid?
        expect(@profile.errors.full_messages).to include "アバター画像を入力してください"
      end
      it '画像が2Mb以上のとき' do
        @profile.image.attach(io: File.open('spec/files/over_size_avatar.jpg'), filename: 'over_size_avatar.jpg')
        @profile.valid?
        expect(@profile.errors.full_messages).to include "アバター画像ファイル サイズは 2MB 未満にする必要があります (現在のサイズは 2.05MB)"
      end
      it '対応していない画像拡張子のとき' do
        @profile.image.attach(io: File.open('spec/files/unsupported_format_avatar.webp'), filename: 'unsupported_format_avatar.webp')
        @profile.valid?
        expect(@profile.errors.full_messages).to include "アバター画像のContent Typeが不正です"
      end
      it '画像に音声ファイルを添付したとき' do
        @profile.image.attach(io: File.open('spec/files/sound.m4a'), filename: 'sound.m4a')
        @profile.valid?
        expect(@profile.errors.full_messages).to include "アバター画像のContent Typeが不正です"
      end
    end
  end
end
