# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConStaff, type: :model do
  before(:all) do
    @event = Event.create(event_year: 2019, event_code: 'GS2019')
    @constaff = ConStaff.new(name: 'Name', event_id: @event.id)
  end

  describe '.new' do
    context 'given valid parms' do
      it 'saves the record and notifies the user' do
        expect(@constaff).to be_valid
      end
    end
    context 'given invalid parms' do
      it 'does not create the record and raises an error' do
        expect(ConStaff.new).not_to be_valid
      end
    end
  end

  describe '.destroy' do
    it 'deletes the referenced record' do
      constaff_count = ConStaff.all.count
      @constaff.save
      expect(ConStaff.all.count).to eq constaff_count + 1
      ConStaff.find(@constaff.id).destroy
      expect(ConStaff.all.count).to eq constaff_count
    end
    it 'PENDING: provides confirmation before deletion'
  end

  describe '.update' do
    context 'given valid parms' do
      it 'like a normal name' do
        new_info = 'New Name'
        @constaff.update(name: new_info)
        expect(@constaff[:name]).to eq(new_info)
      end
      it 'like the string "nil" as a name' do
        new_info = 'nil'
        @constaff.update(name: new_info)
        expect(@constaff[:name]).to eq(new_info)
      end
    end
    context 'given invalid parms' do
      it 'like the value nil' do
        new_info = nil
        @constaff.update(name: new_info)
        expect(@constaff).not_to be_valid
      end
    end
  end
end
