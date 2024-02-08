require 'rails_helper'

RSpec.describe "Api::V1::Cocktails", type: :request do
  describe "Error handling" do
    it "returns an error method when no search parameter is passed" do
      get api_v1_cocktails_path
      expect(response).to have_http_status(200)

      # Response contains error message
      json = JSON.parse(response.body)
      expect(json).to eq []
    end

    it "returns an error message when a too short search parameter is passed" do
      get api_v1_cocktails_path(query: "ab")
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
      expect(Cocktail).to receive(:search).with(query).and_return(cocktail)
    end

    it "returns a database result when a search query is received" do
      get api_v1_cocktails_path(query: query)
      expect(response).to have_http_status(200)

      # Response contains error message
      json = JSON.parse(response.body).deep_symbolize_keys
      puts json.inspect

      expect(json[:error]).to be_blank
      expect(json[:cocktails][:name]).to eq cocktail.name
      expect(json[:cocktails][:category]).to eq cocktail.category
      expect(json[:cocktails][:container]).to eq cocktail.container
      expect(json[:cocktails][:instructions]).to eq cocktail.instructions
      expect(json[:cocktails][:image]).to eq cocktail.image
      expect(json[:cocktails][:ingredients].size).to eq 1
      expect(json[:cocktails][:ingredients].first[:name]).to eq cocktail.ingredients.first.name
      expect(json[:cocktails][:ingredients].first[:measurement]).to eq cocktail.ingredients.first.measurement
    end
  end
end
