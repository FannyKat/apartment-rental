require File.expand_path('../../config/environment', __dir__)

require 'rails_helper'

RSpec.feature 'User login', type: :feature, js: true do
  scenario 'User logs in successfully' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@owner.com'
    fill_in 'Mot de passe', with: 'password'
    click_button 'Se connecter'
  end
end
