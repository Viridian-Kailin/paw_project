# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameLogsController, type: :controller do
  before(:all) do
    @event = Event.create(event_year: 2019, event_code: 'GS2019')
    @game = Inventory.create(title: 'Game', quantity_total: 1)
    @member = Participant.create(badge: rand(99_999), name: 'Name')

    @log = GameLog.new(inventory_id: @game.id, timestamp: Time.now, participant_id: @member.id, rating: 1, event_id: @event.id)
  end

  describe '.need_reg' do
    context 'provided with an existing badge' do
      it 'returns a 304 HTTP status code'
    end
    context 'provided with a new badge' do
      it 'returns a 406 HTTP status code'
    end
  end

  describe 'new' do
    it 'renders the new page' do
      get :new
      expect(response).to have_http_status(302)
    end
    it 'redirects to itself'
  end

  describe 'index' do
    it 'renders the index page'
    it 'renders the edit page within a dialog'
  end

  describe 'edit' do
    it 'renders the edit page'
    it 'redirects to the index page'
  end
end
