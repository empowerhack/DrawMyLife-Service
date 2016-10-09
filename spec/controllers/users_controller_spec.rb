require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user

  describe "GET index" do
    subject(:perform) { get :index }

    it { expect(perform).to have_http_status :success }
    it { perform; expect(assigns(:users)).not_to be_nil }
    it { expect(perform).to render_template :index }
  end
end
