require 'rails_helper'

RSpec.describe UsersController, type: :feature do
  let(:user_params) do
    { name: 'Divyesh' }
  end
  let(:user) { User.new(user_params) }

  describe 'Sign up Process' do
    it 'creates user' do
      visit new_user_path
      fill_in 'user[name]', with: user.name
      click_button('Sign Up')

      expect(page).to have_content('User was Successfully created')
    end
  end

  describe 'Sign in Process' do
    it 'Sign user in' do
      # user.save
      visit new_session_path
      fill_in :name, with: 'Divyesh'
      click_button 'Log In'

      expect(page).to have_text('Logged In Successfull')
    end
  end
end
