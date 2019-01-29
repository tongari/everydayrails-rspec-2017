require 'rails_helper'

RSpec.describe Project, type: :model do
  # ユーザ単位では重複したプロジェクト名を許可しないこと
  it 'does not allow duplicate project names per user' do
    user = User.create(
                 first_name: 'Hoge',
                 last_name: 'Fuga',
                 email: 'hoge@gmail.com',
                 password: 'hogehoge'
    )

    user.projects.create name: 'Test Project'
    new_project = user.projects.build name: 'Test Project'
    new_project.valid?
    expect(new_project.errors[:name]).to include 'has already been taken'
  end

  # 二人のユーザが同じプロジェクト名を使うことは許可する
  it 'allows two users to share a project name' do
    user = User.create(
                 first_name: 'hoge',
                 last_name: 'huga',
                 email: 'hoge@gmail.com',
                 password: 'hogehoge'
    )
    user.projects.create! name: 'Test Project'
    ohter_user = User.create(
                       first_name: 'foo',
                       last_name: 'bar',
                       email: 'foo@gmail.com',
                       password: 'foofoo'
    )
    other_project = ohter_user.projects.build name: 'Test Project'
    expect(other_project).to be_valid
  end

  # プロジェクト名がnilなのを許可しない
  it 'is invalid project name to nil' do
    user = User.create(
      first_name: 'hoge',
      last_name: 'huga',
      email: 'hoge@gmail.com',
      password: 'hogehoge'
    )

    project = user.projects.build
    expect(project).to_not be_valid
    # project.valid?
    # expect(project.errors[:name]).to include "can't be blank"
  end
end
