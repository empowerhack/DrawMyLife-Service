require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET index" do
    subject(:perform) { get :index }

    context "current user is super admin" do
      login_as_super_admin

      it { expect(perform).to have_http_status :success }
      it { perform; expect(assigns(:users)).not_to be_nil }
      it { expect(perform).to render_template :index }
    end

    context "current user is admin" do
      login_as_admin

      it { perform; expect(controller).to set_flash[:error] }
      it { expect(perform).to redirect_to root_path }
    end
  end
end
