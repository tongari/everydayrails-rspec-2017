require 'rails_helper'

RSpec.feature "Homes", type: :feature do

  # ゲストユーザとして
  feature 'as a guest user' do
    # サインインページへリダイレクトする
    scenario 'redirects to the sign-in page' do
      visit root_path
      click_link 'Projects'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
