require 'rails_helper'

describe Api::V1::UsersController do
  describe ".create" do
    it "should creates user with valid params" do
      user_params = {
        email: 'uniq_email@example.com', name: 'Test User', password: 12345678, password_confirmation: 12345678
      }
      post :create, user: user_params
      expect(response.status).to eq 201
      expect(json["email"]).to eq 'uniq_email@example.com'
    end

    it "should't create user if it exist in db" do
      user = FactoryGirl.create(:user)
      post :create, user: {email: user.email, name: user.name, password: 12345678, password_confirmation: 12345678}
      expect(response.status).to eq 422
      expect(json["errors"]).to eq ["Email has already been taken"]
    end

    it "should't create user if password missmatch" do
      post :create, user: {email: 'email@example.com', name: 'name', password: 12345678, password_confirmation: 'wrong one'}
      expect(response.status).to eq 422
    end

    it "should't create user without email" do
      post :create, user: {name: 'name', password: 12345678, password_confirmation: 12345678}
      expect(response.status).to eq 422
      expect(json["errors"]).to eq ["Email can't be blank"]
    end

    it "should't create user without name" do
      post :create, user: {email: 'email@example.com', password: 12345678, password_confirmation: 12345678}
      expect(response.status).to eq 422
      expect(json["errors"]).to eq ["Name can't be blank"]
    end
  end

  private

  def json
    JSON.parse(response.body)
  end

end
