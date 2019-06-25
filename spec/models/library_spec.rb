# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Library, type: :model do
  before(:all) do
    @event = Event.create(event_year: 2019, event_code: 'GS2019')
    @game = Inventory.create(title: 'Game', quantity_total: 1)
    @member = Participant.create(badge: rand(99_999), name: 'Name')

    @checkin = Library.new(checked_out: nil, checked_in: Time.now, quantity_left: 1, inventory_id: @game.id, paw_staff_id: nil, participant_id: @member.id, event_id: @event.id)
    @checkout = @checkin.dup
    @checkout[checked_out: Time.now, checked_in: nil]
  end

  describe '.new' do
    context 'given valid conditions for game check-in' do
      it 'saves the record and notifies the user' do
        expect(@checkin).to be_valid
      end
    end
    context 'given no participant_id for game check-in' do
      it 'does not create the record and raises an error' do
        library = @checkin.dup
        library.update(participant_id: nil)
        expect(library).not_to be_valid
      end
    end
    context 'given no inventory_id for game check-in' do
      it 'does not create the record and raises an error' do
        library = @checkin.dup
        library.update(inventory_id: nil)
        expect(library).not_to be_valid
      end
    end
    context 'given valid conditions for game check-out' do
      it 'saves the record and notifies the user' do
        expect(@checkout).to be_valid
      end
    end
    context 'given no participant_id for game check-out' do
      it 'does not create the record and raises an error' do
        library = @checkout.dup
        library.update(participant_id: nil)
        expect(library).not_to be_valid
      end
    end
    context 'given no inventory_id for game check-out' do
      it 'does not create the record and raises an error' do
        library = @checkout.dup
        library.update(inventory_id: nil)
        expect(library).not_to be_valid
      end
    end
  end

  describe '.destroy' do
    context 'deletes the referenced record' do
      it 'for a check-out log' do
        library_count = Library.all.count
        @checkout.save
        expect(Library.all.length).to eq library_count + 1
        Library.find(@checkout.id).destroy
        expect(Library.all.length).to eq library_count
      end
      it 'for a check-in log' do
        library_count = Library.all.count
        @checkin.save
        expect(Library.all.length).to eq library_count + 1
        Library.find(@checkin.id).destroy
        expect(Library.all.length).to eq library_count
      end
    end
    it 'provides confirmation before deletion'
  end
end
