require 'rails_helper'

RSpec.describe Project, type: :model do
  # ユーザ単位では重複したプロジェクト名を許可しないこと
  it 'does not allow duplicate project names per user' do
    # user = User.create(
    #              first_name: 'Hoge',
    #              last_name: 'Fuga',
    #              email: 'hoge@gmail.com',
    #              password: 'hogehoge'
    # )
    #
    # user.projects.create name: 'Test Project'
    user = FactoryBot.create(:user)
    user.projects.create name: 'Test Project'
    new_project = user.projects.build name: 'Test Project'
    new_project.valid?
    expect(new_project.errors[:name]).to include 'has already been taken'
  end

  # 二人のユーザが同じプロジェクト名を使うことは許可する
  it 'allows two users to share a project name' do
    # user = User.create(
    #              first_name: 'hoge',
    #              last_name: 'huga',
    #              email: 'hoge@gmail.com',
    #              password: 'hogehoge'
    # )
    # user.projects.create! name: 'Test Project'

    FactoryBot.create(:project, name: 'Test Project')

    # ohter_user = User.create(
    #                    first_name: 'foo',
    #                    last_name: 'bar',
    #                    email: 'foo@gmail.com',
    #                    password: 'foofoo'
    # )
    # other_project = ohter_user.projects.build name: 'Test Project'
    #
    project = FactoryBot.build(:project, name: 'Test Project')
    expect(project).to be_valid
  end

  # プロジェクト名がnilなのを許可しない
  it 'is invalid project name to nil' do
    # user = User.create(
    #   first_name: 'hoge',
    #   last_name: 'huga',
    #   email: 'hoge@gmail.com',
    #   password: 'hogehoge'
    # )
    #
    # project = user.projects.build
    project = FactoryBot.build(:project, name: nil)
    expect(project).to_not be_valid
    # project.valid?
    # expect(project.errors[:name]).to include "can't be blank"
  end


  # 遅延ステータス
  describe 'late status' do
    # 締切日がすぎていれば遅延していること
    it 'is late when the due date is past today' do
      # project = FactoryBot.create(:project_due_yesterday)
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    # 締切日が今日ならスケジュールどおりであること
    it 'is on time when the due date is today' do
      # project = FactoryBot.create(:project_due_today)
      project = FactoryBot.create(:project,:due_today)
      expect(project).to_not be_late
    end

    # 締切日が未来ならスケジュールどおりであること
    it 'is on time when the due date is in the future' do
      # project = FactoryBot.create(:project_due_tomorrow)
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end

  # たくさんのメモがついてること
  it 'can have many notes' do
    # project = FactoryBot.create :project, :with_notes
    project = FactoryBot.create :project, :with_notes
    expect(project.notes.length).to eq 5
  end

  # タスクが作成されていること
  it 'make valid task' do
    project = FactoryBot.create(:project, :with_tasks)
    expect(project.tasks.length).not_to eq 0
  end
end
