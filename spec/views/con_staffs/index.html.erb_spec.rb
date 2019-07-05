require 'rails_helper'

RSpec.describe 'con_staffs/index', type: :view do
  before :each do
    5.times do
      ConStaff.create(name: 'Testing', event_id: Event.all[0][:id])
    end
    @con_info = ConStaff.con_list
  end

  describe 'when the user has signed in' do
    context 'as an admin' do
      it 'displays the con staff along with admin functions' do
        render
        expect(rendered).to have_content 'Convention Staff'
      end
    end
    context 'as a staff' do
      it 'displays the con staff without admin functions'
    end
  end

  describe 'when the user has not signed in' do
    it 'redirects to the login page'
  end
end
