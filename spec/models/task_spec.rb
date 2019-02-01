require 'rails_helper'

RSpec.describe Task, type: :model do
  # ユーザ違いでタスク名が一緒でもタスクが作成されていること
  it 'allows two users to share a task name' do
    FactoryBot.create(:task, name: 'My Task')
    task = FactoryBot.build(:task, name: 'My Task')
    expect(task).to be_valid
  end
end
