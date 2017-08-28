require 'rails_helper'

RSpec.describe API::DrawingsController, type: :controller do
  before do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(api_key.access_token)
  end

  let(:api_key) { FactoryGirl.create :api_key }

  describe "GET index" do
    subject(:perform) { get :index, format: :hal }

    it { expect(perform).to have_http_status :success }

    context "body" do
      subject { JSON.parse(perform.body) }
      it { is_expected.to include("drawings") }
    end
  end

  describe "GET show" do
    let(:drawing) { FactoryGirl.create(:drawing) }

    subject(:perform) { get :show, id: drawing, format: :hal }

    it { expect(perform).to have_http_status :success }

    context "body" do
      subject { JSON.parse(perform.body) }
      it { is_expected.to include("description" => drawing.description) }
    end
  end
end
