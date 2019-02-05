require 'rails_helper'

RSpec.feature "Projects", type: :feature do

  # include LoginSupport
  # include Devise::Test::IntegrationHelpers
  # ユーザは新しいプロジェクトを作成する
  scenario 'user create a new project' do
    user  = FactoryBot.create(:user)

    # visit root_path
    # click_link 'Sign in'
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: user.password
    # click_button 'Log in'
    #spec/support/login_support.rbで定義したspecのヘルパー
    # sign_in_as user
    sign_in user
    visit root_path

    expect {
      click_link 'New Project'
      fill_in 'Name', with: 'Test Project'
      fill_in 'Description', with: 'Trying out Capybara'
      click_button 'Create Project'

      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Test Project'
      expect(page).to have_content "Owner: #{user.name}"
      expect(page).to have_content 'Trying out Capybara'
    }.to change(user.projects, :count).by(1)
  end

  # ゲストがプロジェクトを追加する
  scenario 'guest adds a project' do
    visit projects_path
    # click_link 'New Project'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

 end
