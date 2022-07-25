require 'rails_helper'

feature 'Sessions' do
  let!(:user) { create :user, email: 'example@example.com', password: 'password' }

  scenario 'Signing in and signing out' do
    login(email: user.email, password: user.password)

    expect(page).to have_content("Hi #{user.name}")

    logout()

    expect(page).not_to have_content("Hi #{user.name}")
  end
end
