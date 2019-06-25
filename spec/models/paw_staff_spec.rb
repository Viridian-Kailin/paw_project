# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PawStaff, type: :model do
  before(:all) do
    @pawstaff = PawStaff.new(name: 'Name', title: 'Title', phone: '', email: '', badge: 999, role: 'GM')
  end

  describe '.new' do
    it 'given valid parms' do
      expect(@pawstaff).to be_valid
    end
    it 'given invalid parms' do
      expect(PawStaff.new).not_to be_valid
    end
  end

  describe '.destroy' do
    it 'deletes the referenced record' do
      staff_count = PawStaff.all.count
      @pawstaff.save
      expect(PawStaff.all.count).to eq staff_count + 1
      PawStaff.find(@pawstaff.id).destroy
      expect(PawStaff.all.count).to eq staff_count
    end
    it 'provides confirmation before deletion'
  end

  describe '.update' do
    it 'updates the record' do
      new_info = 'New Name'
      @pawstaff.update(name: new_info)
      expect(@pawstaff.name).to eq(new_info)
    end
    it 'does not update parameters' do
      new_info = nil
      @pawstaff.update(name: new_info)
      expect(@pawstaff).not_to be_valid
    end
  end
end
