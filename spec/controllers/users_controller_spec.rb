require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  shared_examples_for "an action only accessible to super_admins" do
    context "current user is super admin" do
      login_as_super_admin

      it { perform; expect(controller).to_not set_flash[:error] }
    end

    context "current user is admin" do
      login_as_admin

      it "sets an appropriate flash error" do
        perform
        expect(controller).to set_flash[:error]
        expect(flash[:error]).to have_content("Sorry, you may be a super human being, but you need to be a super admin to do that.")
      end

      it { expect(perform).to redirect_to root_path }
    end
  end

  describe "GET index" do
    subject(:perform) { get :index }

    it_behaves_like "an action only accessible to super_admins"
  end

  describe "POST create" do
    let(:perform) { post :create, user: params }
    let(:params) { FactoryGirl.attributes_for(:user) }

    it_behaves_like "an action only accessible to super_admins"

    context "with valid params" do
      login_as_super_admin

      it "creates new user" do
        expect{ perform }.to change{ User.count }.by(1)
      end

      it "redirects to index" do
        expect(perform).to redirect_to users_path
      end
    end

    context "with invalid params" do
      login_as_super_admin

      let(:params) { { country: "AE" } }

      it "does not create a user" do
        expect{ perform }.to_not change{ User.count }
      end

      it "renders a flash error on the new template" do
        perform
        expect(flash[:error]).to have_content("Sorry, a new account could not be created. Please review your submission and try again.")
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    let(:perform) { put :update, id: user, user: params }
    let(:user) { FactoryGirl.create(:user, :admin) }
    let(:params) { FactoryGirl.attributes_for(:user, role: "super_admin") }

    it_behaves_like "an action only accessible to super_admins"

    context "with valid params" do
      login_as_super_admin

      it "updates the user" do
        perform
        expect(user.reload.role).to eq(params[:role])
      end

      it "redirects to the user" do
        expect(perform).to redirect_to user_path user.id
      end
    end

    context "with invalid params" do
      login_as_super_admin

      let(:params) { { country: -1 } }

      it "does not update the user" do
        perform

        expect(flash[:success]).to_not have_content("Success! The user details were updated.")
      end

      it "renders a flash error on the new template" do
        perform
        expect(flash[:error]).to have_content("Sorry, your changes could not be saved. Please review your changes and try again.")
        expect(response).to render_template :edit
      end
    end
  end
end
