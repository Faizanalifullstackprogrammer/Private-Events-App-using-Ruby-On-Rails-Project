require 'rails_helper'

RSpec.describe EventsController, type: :system do
  let(:user) { User.create(name: 'Divyesh') }
  let(:event_params) do
    {
      title: 'Event',
      description: 'Event Descriptions',
      location: 'Here',
      creator: user
    }
  end
  let(:event) do
    Event.new(event_params)
  end

  describe 'Event Management' do
    before :each do
      visit new_user_path
      fill_in 'user[name]', with: 'Divyesh'
      click_button('Sign Up')
      visit new_session_path
      fill_in :name, with: 'Divyesh'
      click_button('Log In')
    end

    it 'create Event' do
      visit new_event_path
      fill_in :event_title, with: 'Event'
      fill_in :event_description, with: 'Event Descriptions'
      fill_in :event_location, with: 'Here'
      click_button('Create Event')

      expect(page).to have_content('Event was successfully created.')
    end
  end
end
