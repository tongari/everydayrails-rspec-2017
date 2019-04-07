require 'rails_helper'

RSpec.describe "ProjectsApis", type: :request do

  context 'hoge'  do

    let!(:user) { FactoryBot.create(:user, email: 'ext@gmail.com') }
    let!(:foo) do
      FactoryBot.create_list(:project, 2, owner: user)
    end

    subject(:action) {
      get api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token
      }
    }

    # 1件のプロジェクトを読み出すこと
    it 'loads a project' do
      is_expected.to eq 200
      json = JSON.parse(response.body)
      expect(json.length).to eq 2
      expect(json[-1]['due_on']).to_not eq Date.current.in_time_zone
    end

    context 'fuga' do
      let!(:foo) {
        FactoryBot.create(:project, :due_today, owner: user)
      }
      it {
        subject
        expect(response).to have_http_status :success
        # is_expected.to eq 200
        json = JSON.parse(response.body)
        expect(json.length).to eq 1
        expect(json[-1]['due_on']).to eq Date.current.strftime('%Y-%m-%d')
      }
    end

    it {
      subject
      expect(response).to have_http_status :success
      # is_expected.to eq 200
      json = JSON.parse(response.body)
      binding.pry
      expect(json.length).to eq 2
      expect(json[-1]['due_on']).to_not eq Date.current.in_time_zone
    }
  end


  # # 1件のプロジェクトを読み出すこと
  # it 'loads a project' do
  #   user = FactoryBot.create(:user)
  #   FactoryBot.create(:project, name: 'Sample Project')
  #   FactoryBot.create(:project, name: 'Second Sample Project', owner: user)
  #
  #   get api_projects_path, params: {
  #     user_email: user.email,
  #     user_token: user.authentication_token
  #   }
  #
  #   expect(response).to have_http_status(:success)
  #   json = JSON.parse(response.body)
  #   expect(json.length).to eq 1
  #   project_id = json[0]['id']
  #
  #   get api_project_path(project_id), params: {
  #     user_email: user.email,
  #     user_token: user.authentication_token
  #   }
  #
  #   expect(response).to have_http_status(:success)
  #   json = JSON.parse(response.body)
  #   expect(json['name']).to eq 'Second Sample Project'
  # end

  # プロジェクトを作成できること
  # it 'creates a project' do
  #   user = FactoryBot.create(:user)
  #   project_attributes = FactoryBot.attributes_for(:project)
  #
  #   expect {
  #     post api_projects_path, params: {
  #       user_email: user.email,
  #       user_token: user.authentication_token,
  #       project: project_attributes
  #     }
  #   }.to change(user.projects, :count).by(1)
  #
  #   expect(response).to have_http_status(:success)
  # end
end
