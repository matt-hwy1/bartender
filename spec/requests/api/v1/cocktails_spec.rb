require 'rails_helper'

RSpec.describe "Api::V1::Cocktails", type: :request do
  describe "Error handling" do
    it "Returns an error method when no search parameter is passed" do
      get api_v1_cocktails_path
      expect(response).to have_http_status(400)

      # Response contains error message
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:error][:message]).not_to be_blank
    end
  end
end
