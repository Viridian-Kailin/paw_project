# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameLog, type: :model do
  before(:all) do
    @event = Event.create(event_year: 2019, event_code: 'GS2019')
    @game = Inventory.create(title: 'Game', quantity_total: 1)
    @member = Participant.create(badge: rand(99_999), name: 'Name')

    @log = GameLog.new(inventory_id: 1, timestamp: Time.now, participant_id: 1, rating: 1, event_id: @event.id)
  end

  describe '.new' do
    context 'given valid parms' do
      it 'saves the record and notifies the user' do
        expect(@log).to be_valid
      end
    end
    context 'given that no title is provided' do
      it 'does not submit the entry and raises an error' do
        log_title = @log.dup
        log_title[:inventory_id] = nil
        expect(log_title).not_to be_valid
      end
    end
    context 'given that no entries are provided' do
      it 'does not submit the entry and raises an error' do
        log_entry = @log.dup
        log_entry[:participant_id] = nil
        expect(log_entry).not_to be_valid
      end
    end
    context 'given a blank log is provided' do
      it 'does not submit the entry and raises an error' do
        expect(GameLog.new).not_to be_valid
      end
    end
    # Valid participant_id not currently implemented, issue documented on Trello under "validate badge"
  end

  describe '.destroy' do
    it 'deletes the referenced record' do
      @log.save
      expect(GameLog.all.count).to eq 1
      GameLog.find(@log.id).destroy
      expect(GameLog.all.count).to eq 0
    end
    it 'provides confirmation before deletion'
  end

  describe '.update' do
    it 'updates the rating to the provided integer' do
      new_info = 5
      @log.update(rating: new_info)
      expect(@log[:rating]).to eq(new_info)
    end
    context 'does not update with invalid parms' do
      it 'like null inventory_id' do
        @log.update(inventory_id: nil)
        expect(@log).not_to be_valid
      end
      it 'like null participant_id' do
        @log.update(inventory_id: @game.id, participant_id: nil)
        expect(@log).not_to be_valid
      end
    end
    # it 'does not update any non-rating parameters'
  end

  describe '.log_info' do
    context 'when loading the show page' do
      it 'shows descriptive details for all records'
    end
    context 'when loading the edit page' do
      it 'shows the selected record for updating'
      it 'does not show all records'
    end
  end
end
