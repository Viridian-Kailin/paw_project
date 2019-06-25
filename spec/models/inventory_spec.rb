# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory, type: :model do
  before(:all) do
    @game = Inventory.new(title: 'Title', company: 'Company', quantity_total: 1)
  end

  describe '.new' do
    context 'given valid parms' do
      it 'saves the record and notifies the user' do
        expect(@game).to be_valid
      end
    end
    context 'given invalid parms' do
      it 'does not create the record and raises an error' do
        expect(Inventory.new).not_to be_valid
      end
    end
  end

  describe '.destroy' do
    it 'deletes the referenced record' do
      game_count = Inventory.all.length
      @game.save
      expect(Inventory.all.length).to eq game_count + 1
      Inventory.find(@game.id).destroy
      expect(Inventory.all.length).to eq game_count
    end
    it 'provides confirmation before deletion'
  end

  describe '.update' do
    it 'updates the record' do
      new_info = 'New Title'
      @game.update(title: new_info)
      expect(@game[:title]).to eq(new_info)
    end
    it 'does not update record' do
      @game.update(title: nil)
      expect(@game).not_to be_valid
    end
  end
end
