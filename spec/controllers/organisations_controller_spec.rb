require 'rails_helper'

RSpec.describe OrganisationsController, type: :controller do
  login_user

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
  end
end
