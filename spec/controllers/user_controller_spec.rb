require 'rails_helper'

describe UsersController, type: :controller do
  describe "GET #new" do
    it "returns a success response" do
      get :show
      expect(response).to be_success
    end
  end
end
