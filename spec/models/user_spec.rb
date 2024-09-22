# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
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

  context 'emailがnilの場合' do
    let!(:user){ build(:user, email: '') }

    before do
      user.save
    end

    it 'ユーザー情報が保存されない' do
      expect(user.errors.messages[:email][0]).to eq("can't be blank")
    end
  end

  context 'emailがすでに存在する場合' do
    let!(:user1){ create(:user, email: 'test@example.com') }
    let!(:user2){ build(:user, email: 'test@example.com') }

    before do
      user2.save
    end

    it 'ユーザー情報が保存されない' do
      expect(user2).not_to be_valid
      expect(user2.errors.messages[:email][0]).to eq("has already been taken")
    end
  end

  context 'usernameがすでに存在する場合' do
    let!(:user1){ create(:user, username: 'test') }
    let!(:user2){ build(:user, username: 'test') }

    before do
      user2.save
    end

    it 'ユーザー情報が保存されない' do
      expect(user2).not_to be_valid
      expect(user2.errors.messages[:username][0]).to eq("has already been taken")
    end
  end

  context 'emailの形式が誤っている場合' do
    let!(:user){ build(:user, email: 'test') }

    before do
      user.save
    end

    it 'ユーザー情報が保存されない' do
      expect(user).not_to be_valid
      expect(user.errors.messages[:email][0]).to eq("is invalid")
    end
  end  

  context 'passwordが空欄の場合' do
    let!(:user){ build(:user, password: '') }

    before do
      user.save
    end

    it 'ユーザー情報が保存されない' do
      expect(user).not_to be_valid
      expect(user.errors.messages[:password][0]).to eq("can't be blank")
    end
  end


end
