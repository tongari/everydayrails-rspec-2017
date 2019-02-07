require 'rails_helper'

RSpec.describe GeocodeUserJob, type: :job do
  # userのgeocodeを呼ぶ事
  it 'calls geocode on the user' do
    user = instance_double('User')
    binding.pry
    expect(user).to receive(:geocode)
    GeocodeUserJob.perform_now(user)
  end
end
