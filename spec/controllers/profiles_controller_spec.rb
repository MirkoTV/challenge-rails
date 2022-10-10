require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe "POST /" do
    it "does not permit superuser flag" do
      expect(Profile).to receive(:new).
        with({ username: "Bob" }.with_indifferent_access)
        .and_return(Profile.new(username: "Bob")) 

      post :create, params: { username: "Bob", superuser: true }
    end
  end
end