require 'rails_helper'

RSpec.describe DrawingsController, type: :controller do
  login_as_super_admin

  before do
    allow_any_instance_of(Drawing).to receive(:can_view?).and_return(true)
    allow_any_instance_of(Drawing).to receive(:can_modify?).and_return(true)
  end

  shared_examples_for "any modifying action" do
    context "with incorrect access" do
      before do
        allow_any_instance_of(Drawing).to receive(:can_modify?).and_return(false)
      end

      it "redirects to root path" do
        expect(perform).to redirect_to root_path
      end

      it "renders a flash error" do
        perform
        expect(flash[:alert]).to have_content("You do not have permission to edit or delete this drawing.")
      end
    end
  end

  describe "POST create" do
    let(:perform) { post :create, drawing: params }
    let(:params) { FactoryGirl.attributes_for(:drawing) }

    context "with valid params" do
      it "creates new drawing" do
        expect{ perform }.to change{ Drawing.count }.by(1)
      end

      it "redirects to index" do
        expect(perform).to redirect_to drawings_path
      end
    end

    context "with invalid params" do
      let(:params) { { description: "This is not enough" } }

      it "does not create a drawing" do
        expect{ perform }.to_not change{ Drawing.count }
      end

      it "renders a flash error on the new template" do
        perform
        expect(flash[:error]).to have_content("Sorry, your drawing could not be saved. Please review your changes and try again.")
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    let(:perform) { put :update, id: drawing, drawing: params }
    let(:drawing) { FactoryGirl.create(:drawing, user: controller.current_user) }
    let(:params) { FactoryGirl.attributes_for(:drawing, description: "A different description") }

    context "with valid params" do
      it "updates the drawing" do
        perform
        expect(drawing.reload.description).to eq(params[:description])
      end

      it "redirects to the drawing" do
        expect(perform).to redirect_to drawing_path drawing
      end
    end

    context "with invalid params" do
      let(:params) { { age: "not a valid age" } }

      it "does not update the drawing" do
        perform
        expect(flash[:success]).to_not have_content("Your drawing was updated.")
      end

      it "renders a flash error on the new template" do
        perform
        expect(flash[:error]).to have_content("Sorry, your drawing could not be saved. Please review your changes and try again.")
        expect(response).to render_template :edit
      end
    end

    it_behaves_like "any modifying action"
  end

  describe "GET index" do
    subject(:perform) { get :index }

    it { expect(perform).to have_http_status :success }

    context "HTML request" do
      it do
        perform
        expect(assigns(:drawings)).not_to be_nil
      end
      it { expect(perform).to render_template :index }
    end

    context "JSON HAL request" do
      let(:perform) { get :index, format: :hal }

      it do
        perform
        expect(assigns(:drawings)).not_to be_nil
      end

      context "body" do
        subject { JSON.parse(perform.body) }
        it { is_expected.to include("drawings") }
      end
    end
  end

  describe "GET show" do
    let(:drawing) { FactoryGirl.create(:drawing) }

    subject(:perform) { get :show, id: drawing }

    it { expect(perform).to have_http_status :success }

    context "HTML request" do
      subject(:perform) { get :show, id: drawing }

      it do
        perform
        expect(assigns(:drawing)).not_to be_nil
      end

      it { expect(perform).to render_template :show }
    end

    context "JSON HAL request" do
      let(:perform) { get :show, id: drawing, format: :hal }

      it do
        perform
        expect(assigns(:drawing)).not_to be_nil
      end

      context "body" do
        subject { JSON.parse(perform.body) }
        it { is_expected.to include("description" => drawing.description) }
      end
    end

    context "with incorrect access" do
      before do
        allow_any_instance_of(Drawing).to receive(:can_view?).and_return(false)
      end

      it "redirects to root path" do
        expect(perform).to redirect_to root_path
      end

      it "renders a flash error" do
        perform
        expect(flash[:alert]).to have_content("You do not have permission to view this drawing.")
      end
    end
  end

  describe "GET edit" do
    let(:drawing) { FactoryGirl.create(:drawing) }

    subject(:perform) { get :edit, id: drawing }

    it_behaves_like "any modifying action"
  end

  describe "DELETE destroy" do
    let(:drawing) { FactoryGirl.create(:drawing) }

    subject(:perform) { delete :destroy, id: drawing }

    it_behaves_like "any modifying action"
  end
end
