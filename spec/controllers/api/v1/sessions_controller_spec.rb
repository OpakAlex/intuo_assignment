require 'rails_helper'

describe Api::V1::SessionsController do
  describe ".create" do
    it "should login exist user with correct password" do
      user = FactoryGirl.create(:user, password: '12345678', password_confirmation: '12345678')
      post :create, user: {email: user.email, password: 12345678}
      expect(response.status).to eq 201
    end

    it "should't login user with wrong password" do
      user = FactoryGirl.create(:user, password: '12345678', password_confirmation: '12345678')
      post :create, user: {email: user.email, password: 1234}
      expect(response.status).to eq 401 
    end

    it "should't login not exist user" do
      post :create, user: {email: 'not_exist_email@example.com', password: 1234}
      expect(response.status).to eq 401 
    end
  end
end
