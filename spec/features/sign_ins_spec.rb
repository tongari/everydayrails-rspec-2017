require 'rails_helper'

RSpec.feature "SignIns", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  # ユーザのログイン
  scenario 'user signs in' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect {
      GeocodeUserJob.perform_later(user)
    }.to have_enqueued_job.with(user)

    # expect(GeocodeUserJospec/jobs/geocode_user_job_spec.rbb.perform_later(user)).to have_enqueued_job.with(user)
  end
end