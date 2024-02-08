require 'rails_helper'

RSpec.describe "Api::Cocktails", type: :request do
  describe "Error handling" do
    it "returns an error method when no search parameter is passed" do
      get api_search_path
      expect(response).to have_http_status(200)

      # Response contains error message
      json = JSON.parse(response.body)
      expect(json).to eq []
    end

    it "returns an error message when a too short search parameter is passed" do
      get api_search_path(query: "ab")
      expect(response).to have_http_status(200)

      # Response contains error message
      json = JSON.parse(response.body)
      expect(json).to eq []
    end
  end

  describe "valid requests" do
    let(:cocktail) {
      FactoryBot.create(:cocktail_with_ingredients, name: "Vodka tonic")
    }
    let(:query) { "vod" }

    before do
      expect(Cocktail).to receive(:search).with(query, nil, nil).and_return(cocktail)
    end

    it "returns a database result when a search query is received" do
      get api_search_path(query: query)
      expect(response).to have_http_status(200)

      # Response contains error message
      json = JSON.parse(response.body).deep_symbolize_keys
      puts json.inspect

      expect(json[:drinks][:name]).to eq cocktail.name
      expect(json[:drinks][:category]).to eq cocktail.category
      expect(json[:drinks][:container]).to eq cocktail.container
      expect(json[:drinks][:instructions]).to eq cocktail.instructions
      expect(json[:drinks][:image]).to eq cocktail.image
      expect(json[:drinks][:ingredients].size).to eq 1
      expect(json[:drinks][:ingredients].first[:name]).to eq cocktail.ingredients.first.name
      expect(json[:drinks][:ingredients].first[:measurement]).to eq cocktail.ingredients.first.measurement
    end
  end
end
