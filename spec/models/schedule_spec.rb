# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before(:all) do
    @event = Event.create(event_year: 2019, event_code: 'GS2019')
    @game = Inventory.create(title: 'Game', quantity_total: 1)
    @staff = PawStaff.create(name: 'Name')

    @schedule = Schedule.new(start: Time.now, end: Time.now + 30, location: '', inventory_id: @game.id, paw_staff_id: @staff.id, event_id: @event.id)
  end

  describe '.new' do
    it 'given valid conditions' do
      expect(@schedule).to be_valid
    end
    context 'does not create the record and raises an error' do
      it 'when no start time set' do
        schedule = @schedule.dup
        schedule[:start] = nil
        expect(schedule).not_to be_valid
      end
      it 'when no end time set' do
        schedule = @schedule.dup
        schedule[:end] = nil
        expect(schedule).not_to be_valid
      end
      it 'when no inventory_id time set' do
        schedule = @schedule.dup
        schedule[:inventory_id] = nil
        expect(schedule).not_to be_valid
      end
    end
  end

  describe '.destroy' do
    it 'deletes the referenced record' do
      schedule_count = Schedule.all.count
      @schedule.save
      expect(Schedule.all.count).to eq schedule_count + 1
      Schedule.find(@schedule.id).destroy
      expect(Schedule.all.count).to eq schedule_count
    end
    it 'provides confirmation before deletion'
  end

  describe '.update' do
    context 'updates the record' do
      it 'for starting time' do
        schedule = @schedule.dup
        new_info = { start: Time.now + 30 }
        schedule.update(new_info)
        expect(schedule[:start]).to eq(new_info[:start])
      end
      it 'for ending time' do
        schedule = @schedule.dup
        new_info = { end: Time.now + 30 }
        schedule.update(new_info)
        expect(schedule[:end]).to eq(new_info[:end])
      end
      it 'for game' do
        schedule = @schedule.dup
        new_game = Inventory.create(title: 'New Game')
        new_info = { inventory_id: new_game[:id] }
        schedule.update(new_info)
        expect(schedule[:inventory_id]).to eq(new_game.id)
      end
    end
    context 'does not update parameters' do
      it 'for invalid starting time' do
        schedule = @schedule.dup
        new_info = { start: nil }
        schedule.update(new_info)
        expect(schedule).not_to be_valid
      end
      it 'for invalid ending time' do
        schedule = @schedule.dup
        new_info = { end: nil }
        schedule.update(new_info)
        expect(schedule).not_to be_valid
      end
      it 'for invalid game' do
        schedule = @schedule.dup
        new_info = { inventory_id: nil }
        schedule.update(new_info)
        expect(schedule).not_to be_valid
      end
    end
  end
end
