require 'rails_helper'

RSpec.describe Task, type: :model do
  # 学習的にオリジナルで記述したもの
  # ユーザ違いでタスク名が一緒でもタスクが作成されていること
  # it 'allows two users to share a task name' do
  #   FactoryBot.create(:task, name: 'My Task')
  #   task = FactoryBot.build(:task, name: 'My Task')
  #   expect(task).to be_valid
  # end
  #

  let(:project) { FactoryBot.create :project }

  # プロジェットと名前があれば有効な状態であること
  it 'is valid with a project and name' do
    task = Task.new(
                 project: project,
                 name: 'Test task',
    )
    expect(task).to be_valid
  end

  # プロジェットがなければ無効な状態であること
  it 'is invalid without a project' do
    task = Task.new(project: nil)
    task.valid?
    expect(task.errors[:project]).to include 'must exist'
  end

  # 名前がなければ無効な状態であること
  it 'is invalid without a name' do
    task = Task.new(name: nil)
    task.valid?
    expect(task.errors[:name]).to include "can't be blank"
  end
end
