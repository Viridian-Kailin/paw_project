# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  before(:all) do
    @member_pxy = Participant.new(badge: rand(99_999), name: 'Name', phone: '', email: '', pref: 'Text', proxy: true, p_badge: 998, p_name: 'Proxy', p_phone: nil, p_email: nil, p_pref: nil)
    @member_nopxy = @member_pxy.dup
    @member_nopxy[proxy: false, p_badge: nil, p_name: nil, p_phone: nil, p_email: nil, p_pref: nil]
  end

  describe '.new' do
    context 'saves the record and notifies the user' do
      it 'when valid parms provided without proxy' do
        expect(@member_nopxy).to be_valid
      end
      it 'when valid parms provided with proxy' do
        expect(@member_pxy).to be_valid
      end
    end
    context 'does not create the record and raises an error' do
      it 'if no name provided with no proxy set' do
        participant = @member_nopxy.dup
        participant.name = nil
        expect(participant).not_to be_valid
      end
      it 'if no badge provided with no proxy set' do
        participant = @member_nopxy.dup
        participant.badge = nil
        expect(participant).not_to be_valid
      end
      it 'if no name provided with proxy set' do
        participant = @member_pxy.dup
        participant.name = nil
        expect(participant).not_to be_valid
      end
      it 'if no badge provided with proxy set' do
        participant = @member_pxy.dup
        participant.badge = nil
        expect(participant).not_to be_valid
      end
    end
  end

  describe '.destroy' do
    context 'deletes the referenced record' do
      it 'for a non-proxy member' do
        member_count = Participant.all.count
        @member_nopxy.save
        expect(Participant.all.count).to eq member_count + 1
        Participant.find(@member_nopxy.id).destroy
        expect(Participant.all.count).to eq member_count
      end
      it 'for a proxy member' do
        member_count = Participant.all.count
        @member_pxy.save
        expect(Participant.all.count).to eq member_count + 1
        Participant.find(@member_pxy.id).destroy
        expect(Participant.all.count).to eq member_count
      end
    end
    it 'provides confirmation before deletion'
  end

  describe '.update' do
    context 'updates the record' do
      context 'for a non-proxy member\'s' do
        it 'name' do
          new_info = 'New Name'
          @member_nopxy.update(name: new_info)
          expect(@member_nopxy[:name]).to eq(new_info)
        end
        it 'badge' do
          new_info = rand(99_999)
          @member_nopxy.update(badge: new_info)
          expect(@member_nopxy[:badge]).to eq(new_info)
        end
      end
      context 'for a proxy member\'s' do
        it 'name' do
          new_info = 'New Name'
          @member_pxy.update(name: new_info)
          expect(@member_pxy[:name]).to eq(new_info)
        end
        it 'badge' do
          new_info = rand(99_999)
          @member_pxy.update(badge: new_info)
          expect(@member_pxy[:badge]).to eq(new_info)
        end
      end
      it 'to add a proxy' do
        new_info = { proxy: true, p_badge: 666, p_name: 'New Proxy' }
        @member_nopxy.update(new_info)
        expect(@member_nopxy[:proxy]).to be true
      end
      it 'to update a proxy' do
        new_info = { p_phone: '666-666-6666' }
        @member_nopxy.update(new_info)
        expect(@member_nopxy[:p_phone]).not_to be nil
      end
      it 'to remove a proxy' do
        new_info = { proxy: false }
        @member_nopxy.update(new_info)
        expect(@member_nopxy[:proxy]).to be false
      end
    end
    it 'does not update parms' do
      new_info = { badge: nil, name: nil }
      @member_pxy.update(new_info)
      expect(@member_pxy).not_to be_valid
    end
  end
end
