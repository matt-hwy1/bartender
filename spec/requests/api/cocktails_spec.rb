require 'rails_helper'

RSpec.describe "Api::Cocktails", type: :request do
  let!(:cocktail) { FactoryBot.create(:cocktail_with_ingredients, name: "Vodka tonic") }
  let(:query) { "vod" }

  describe "error handling" do
    it "returns an empty array when no search parameter is passed" do
      get api_search_path

      response_json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to have_http_status(200)
      expect(response_json[:drinks]).to eq []
    end

    it "returns an empty array when a search parameter doesn't match anything" do
      get api_search_path(query: "xyz")

      response_json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to have_http_status(200)
      expect(response_json[:drinks]).to eq []
    end

    it "returns an empty array when out of bounds pagination parameters are received" do
      get api_search_path(query: query, offset: 5, limit: 10)

      response_json = JSON.parse(response.body).deep_symbolize_keys
      expect(response).to have_http_status(200)
      expect(response_json[:drinks]).to be_blank
    end
  end

  describe "valid search requests" do
    it "returns a database result when a search query is received" do
      get api_search_path(query: query)

      response_json = JSON.parse(response.body).deep_symbolize_keys
      drink = response_json[:drinks].first

      expect(response).to have_http_status(200)

      expect(drink[:name]).to eq cocktail.name
      expect(drink[:category]).to eq cocktail.category
      expect(drink[:container]).to eq cocktail.container
      expect(drink[:instructions]).to eq cocktail.instructions
      expect(drink[:image]).to eq cocktail.image
      expect(drink[:ingredients].size).to eq 1
      expect(drink[:ingredients].first[:name]).to eq cocktail.ingredients.first.name
      expect(drink[:ingredients].first[:measurement]).to eq cocktail.ingredients.first.measurement
    end

    it "calls the search function with the received pagination parameters" do
      get api_search_path(query: query, offset: 0, limit: 10)

      response_json = JSON.parse(response.body).deep_symbolize_keys
      drink = response_json[:drinks].first

      expect(response).to have_http_status(200)

      expect(drink[:name]).to eq cocktail.name
      expect(drink[:category]).to eq cocktail.category
      expect(drink[:container]).to eq cocktail.container
      expect(drink[:instructions]).to eq cocktail.instructions
      expect(drink[:image]).to eq cocktail.image
      expect(drink[:ingredients].size).to eq 1
      expect(drink[:ingredients].first[:name]).to eq cocktail.ingredients.first.name
      expect(drink[:ingredients].first[:measurement]).to eq cocktail.ingredients.first.measurement
    end

    it "returns the correct cocktail by id" do
      get api_detail_path(id: cocktail.id)

      response_json = JSON.parse(response.body).deep_symbolize_keys
      drink = response_json[:drinks].first

      expect(response).to have_http_status(200)

      expect(drink[:name]).to eq cocktail.name
      expect(drink[:category]).to eq cocktail.category
      expect(drink[:container]).to eq cocktail.container
      expect(drink[:instructions]).to eq cocktail.instructions
      expect(drink[:image]).to eq cocktail.image
      expect(drink[:ingredients].size).to eq 1
      expect(drink[:ingredients].first[:name]).to eq cocktail.ingredients.first.name
      expect(drink[:ingredients].first[:measurement]).to eq cocktail.ingredients.first.measurement
    end

    it "queries the database using the received pagination parameters" do
      ("a".."z").each do |index|
        FactoryBot.create(:cocktail, name: "Cocktail #{index}")
      end

      get api_search_path(query: "ocktail", offset: 20, limit: 10)

      response_json = JSON.parse(response.body).deep_symbolize_keys
      drinks = response_json[:drinks]

      expect(response).to have_http_status(200)
      expect(drinks.size).to eq(6)
      expected_results = ["Cocktail u", "Cocktail v", "Cocktail w", "Cocktail x", "Cocktail y", "Cocktail z"]
      expect(drinks.map { |d| d[:name] }).to eq(expected_results)
    end
  end
end
