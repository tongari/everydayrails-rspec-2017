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

      # expect(page).to have_content 'Project was successfully created'
      # expect(page).to have_content 'Test Project'
      # expect(page).to have_content "Owner: #{user.name}"
      # expect(page).to have_content 'Trying out Capybara'
    }.to change(user.projects, :count).by(1)

    aggregate_failures do
      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Test Project'
      expect(page).to have_content "Owner: #{user.name}"
      expect(page).to have_content 'Trying out Capybara'
    end
  end

  # ゲストがプロジェクトを追加する
  scenario 'guest adds a project' do
    visit projects_path
    # click_link 'New Project'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  # ユーザはプロジェクトを完了済みにする
  scenario 'user completes a project' do
    # プロジェクトを持ったユーザを準備する
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user)
    # ユーザはログインしている
    sign_in user
    # ユーザがプロジェクト画面を開き、
    visit project_path(project)
    # 完了済みのラベルが表示されていない
    expect(page).to_not have_content 'Completed'
    # completeボタンをクリックすると、
    click_button 'Complete'
    # プロジェクトは完了済みとしてマークされる
    expect(project.reload.completed?).to be true
    # フラッシュメッセージでプロジェクトが完了した旨が表示される
    expect(page).to have_content 'Congratulations, this project is complete!'
    # 完了済みのラベルが表示される
    expect(page).to have_content 'Completed'
    # 完了済みにするボタンが存在しない
    expect(page).to_not have_button 'Complete'
  end
 end
