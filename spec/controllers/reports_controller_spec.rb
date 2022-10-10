require 'rails_helper'
require 'external/client'

RSpec.describe ReportsController, type: :controller do
  

  describe "GET /index" do
    let!(:profile_1) { Profile.create(username: "Bob") }
    let!(:profile_2) { Profile.create(username: "Jhon") }
    let!(:profile_3) { Profile.create(username: "Scott") }

    it "generates one report per profile" do
      get :index, :format => :json

      expect(response).to be_successful

      body = JSON.parse(response.body)
      expect(body[0]["username"]).to eq(profile_1.username)
      expect(body[1]["username"]).to eq(profile_2.username)
      expect(body[2]["username"]).to eq(profile_3.username)
    end

    it "filters reports per repository tags" do
      repo_1 = Repository.create(profile_id: profile_1.id, name: "repo1", tags: "repo_1")
      repo_2 = Repository.create(profile_id: profile_2.id, name: "repo2", tags: "repo_2")

      get :index, :format => :json, :params => { tags: "repo_2"}

      expect(response).to be_successful

      body = JSON.parse(response.body)
      expect(body.length).to eq(1)
      expect(body[0]["username"]).to eq(profile_2.username)
    end
  end

  describe "GET /reports/external" do
    let(:profiles) do
      [
        {
          id: 1,
          username: "Bob"
        }, {
          id: 2,
          username: "Jhon"
        }, {
          id: 3,
          username: "Scott"
        }
      ]
    end

    let(:repositories) do
      [
        {
          name: "repo_1",
          profile_id: 1
        }, {
          name: "repo_2",
          profile_id: 2
        }, {
          name: "repo_3",
          profile_id: 3
        }
      ]
    end

    before do
      allow_any_instance_of(External::Client).to receive(:fetch_profiles)
        .and_return(profiles)

      allow_any_instance_of(External::Client).to receive(:fetch_repositories)
        .and_return(repositories)
    end

    it "generates one report per profile" do
      get :reports_external, :format => :json

      expect(response).to be_successful

      body = JSON.parse(response.body)
      expect(body[0]["username"]).to eq(profiles[0]["username"])
      expect(body[1]["username"]).to eq(profiles[1]["username"])
      expect(body[2]["username"]).to eq(profiles[2]["username"])
    end

    it "attaches reports to the reports" do
      get :reports_external, :format => :json

      expect(response).to be_successful

      body = JSON.parse(response.body)
      expect(body[0]["repositories"][0]["name"]).to eq(repositories[0]["name"])
      expect(body[1]["repositories"][0]["name"]).to eq(repositories[1]["name"])
      expect(body[2]["repositories"][0]["name"]).to eq(repositories[2]["name"])
    end
  end
end