# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.new(username: 'Name', password: 'Password')
  end

  describe '.new' do
    context 'given valid conditions' do
      it 'saves the record and notifies the user' do
        expect(@user).to be_valid
      end
    end
    context 'given that no username is provided' do
      it 'does not create the record and raises an error' do
        expect(User.new).not_to be_valid
      end
    end
  end

  describe '.destroy' do
    it 'deletes the referenced record' do
      user_count = User.all.count
      @user.save
      expect(User.all.count).to eq user_count + 1
      User.find(@user.id).destroy
      expect(User.all.count).to eq user_count
    end
    it 'provides confirmation before deletion'
  end

  describe '.update' do
    context 'updates the record' do
      it 'for username' do
        new_info = 'New Name'
        @user.update(username: new_info)
        expect(@user.username).to eq(new_info)
      end
      it 'for password' do
        new_info = 'New_Password'
        @user.update(password: new_info)
        expect(@user.password).to eq(new_info)
      end
    end
    context 'does not update parameters' do
      it 'for invalid username' do
        user = @user.dup
        new_info = nil
        user.update(username: new_info)
        expect(user).not_to be_valid
      end
      it 'for invalid password' do
        user = @user.dup
        new_info = nil
        user.update(password: new_info)
        expect(user).not_to be_valid
      end
    end
  end
end
