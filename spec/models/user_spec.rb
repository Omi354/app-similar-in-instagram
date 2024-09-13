require 'rails_helper'

RSpec.describe User, type: :model do
  context '正しい情報が与えられた場合' do
    let!(:user) { build(:user) }

    it 'ユーザー情報が保存される' do
      expect(user).to be_valid
    end
  end

  context 'usernameがnilの場合' do
    let!(:user){ build(:user, username: '') }

    before do
      user.save
    end

    it 'ユーザー情報が保存されない' do
      expect(user.errors.messages[:username][0]).to eq("can't be blank")
    end
  end
end
