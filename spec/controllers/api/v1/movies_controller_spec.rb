require 'rails_helper'

describe Api::V1::MoviesController do
  before :each do 
    @user = FactoryGirl.create(:user)
    auth(@user) 
  end

  describe ".index" do
    it "returns moveis" do
      FactoryGirl.create_list(:movie, 30)
      get :index
      expect(json["movies"].size).to eq 25
    end
  end

  describe ".show" do
    it "returns movie by id" do
      movie = FactoryGirl.create(:movie)
      get :show, id: movie.id
      expect(json["movie"]["id"]).to eq movie.id
    end
  end

  describe ".create" do
    it "creates movie by user" do
      movie = {title: 1, rating: 1, members: ["Alex"]}
      post :create, movie: movie
      expect(response.status).to eq 201
    end
  end
end
