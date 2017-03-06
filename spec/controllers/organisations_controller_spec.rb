require 'rails_helper'

RSpec.describe OrganisationsController, type: :controller do
  login_as_super_admin

  shared_examples_for "an unauthorized user" do
    context "with incorrect access" do
      login_as_admin

      it "redirects to root path" do
        expect(perform).to redirect_to root_path
      end

      it "renders a flash error" do
        perform
        expect(flash[:error]).to have_content("Sorry, you may be a super human being, but you need to be a super admin to do that.")
      end
    end
  end

  describe "GET index" do
    subject(:perform) { get :index }

    it { expect(perform).to have_http_status :success }
    it do
      perform
      expect(assigns(:organisations)).not_to be_nil
    end
    it { expect(perform).to render_template :index }

    it_behaves_like "an unauthorized user"
  end

  describe "GET show" do
    subject(:perform) { get :show, id: organisation }
    let(:organisation) { FactoryGirl.create(:organisation) }

    it { expect(perform).to have_http_status :success }
    it do
      perform
      expect(assigns(:organisation)).not_to be_nil
    end
    it { expect(perform).to render_template :show }

    it_behaves_like "an unauthorized user"
  end

  describe "POST create" do
    let(:perform) { post :create, organisation: params }
    let(:params) { FactoryGirl.attributes_for(:organisation) }

    context "with valid params" do
      it "creates new organisation" do
        expect{ perform }.to change{ Organisation.count }.by(1)
      end

      it "redirects to index" do
        expect(perform).to redirect_to organisations_path
      end
    end

    context "with invalid params" do
      let(:params) { { name: "" } }

      it "does not create an organisation" do
        expect{ perform }.to_not change{ Organisation.count }
      end

      it "renders a flash error on the new template" do
        perform
        expect(flash[:error]).to have_content("Sorry, your organisation could not be saved. Please review your changes and try again.")
        expect(response).to render_template :new
      end
    end

    it_behaves_like "an unauthorized user"
  end

  describe "PUT update" do
    let(:perform) { put :update, id: organisation, organisation: params }
    let(:organisation) { FactoryGirl.create(:organisation) }
    let(:params) { FactoryGirl.attributes_for(:organisation, name: "A different name") }

    context "with valid params" do
      it "updates the organisation" do
        perform
        expect(organisation.reload.name).to eq(params[:name])
      end

      it "redirects to index" do
        expect(perform).to redirect_to organisations_path
      end
    end

    context "with invalid params" do
      let(:params) { { name: "" } }

      it "does not update the drawing" do
        perform
        expect(flash[:success]).to_not have_content("Your organisation was updated.")
      end

      it "renders a flash error on the new template" do
        perform
        expect(flash[:error]).to have_content("Sorry, your organisation could not be saved. Please review your changes and try again.")
        expect(response).to render_template :edit
      end
    end

    it_behaves_like "an unauthorized user"
  end
end
