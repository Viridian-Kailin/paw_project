# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:all) do
    @event = Event.new(event_code: 'GSXXXX', event_year: '2000', set: false, event_location: 'Location')
  end

  describe '.new' do
    context 'given valid parms' do
      it 'saves the record and notifies the user' do
        expect(@event).to be_valid
      end
    end
    context 'given invalid parms' do
      it 'does not create the record and raises an error' do
        expect(Event.new).not_to be_valid
      end
    end
  end

  describe '.destroy' do
    it 'deletes the referenced record' do
      event_count = Event.all.length
      @event.save
      expect(Event.all.count).to eq event_count + 1
      Event.find(@event.id).destroy
      expect(Event.all.count).to eq event_count
    end
    it 'provides confirmation before deletion'
  end

  describe '.update' do
    it 'updates the record when parms valid' do
      new_info = '2019'
      @event.update(event_code: new_info)
      expect(@event[:event_code]).to eq(new_info)
    end
    it 'does not update record when parms invalid' do
      new_info = nil
      @event.update(event_code: new_info)
      expect(@event).not_to be_valid
    end
  end
end
