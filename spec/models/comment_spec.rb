require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'comment投稿' do
    context "投稿できるとき" do
      it 'textが正常に入力される' do
        @comment.valid?
        expect(@comment).to be_valid
      end
    end
    context "投稿できないとき" do
      it 'textが空' do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "コメントを入力してください"
      end
      it 'profileが選択されていない' do
        @comment.profile = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "プロフィールを入力してください"
      end
    end
  end

end
