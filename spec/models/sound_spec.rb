require 'rails_helper'

RSpec.describe Sound, type: :model do
  before do
    @sound = FactoryBot.build(:sound)
  end
  describe 'sound新規作成' do
    context "作成できるとき" do
      it 'すべての項目が正常に入力される' do
        @sound.valid?
        expect(@sound).to be_valid
      end
    end
    context "作成できないとき" do
      it 'テキストがないとき' do
        @sound.text = ""
        @sound.valid?
        expect(@sound.errors.full_messages).to include "タイトル・説明文を入力してください"
      end
      it '音声ファイルがないとき' do
        @sound.sound = nil
        @sound.valid?
        expect(@sound.errors.full_messages).to include "音声ファイルを入力してください"
      end
      it '画像ファイルを添付したとき' do
        @sound.sound.attach(io: File.open('spec/files/over_size_avatar.jpg'), filename: 'over_size_avatar.jpg')
        @sound.valid?
        expect(@sound.errors.full_messages).to include "音声ファイルのContent Typeが不正です"
      end
      it 'profileが選択されていない' do
        @sound.profile = nil
        @sound.valid?
        expect(@sound.errors.full_messages).to include "プロフィールを入力してください"
      end
    end
  end


end
