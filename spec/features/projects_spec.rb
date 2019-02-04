require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  # ユーザは新しいプロジェクトを作成する
  scenario 'user create a new project' do
    user  = FactoryBot.create(:user)

    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

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
    click_link 'New Project'
  end

 end
