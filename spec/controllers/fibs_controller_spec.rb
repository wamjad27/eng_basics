require 'rails_helper'

RSpec.describe FibsController, type: :controller do
  let(:valid_attributes) { {space: 10} }
  let(:invalid_attributes) { {sql_inject: '\drop fibs;'} }

  context "GET actions" do
    before do
      @fib = Fib.create! valid_attributes
      @fib.generate && @fib.save
    end

    describe "GET #index" do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_success
      end
    end
  end

  context "Secure actions" do
    describe "POST #create" do
      context "with valid params" do
        it "creates a new Fib" do
          expect {
            post :create, params: {fib: valid_attributes}
          }.to change(Fib, :count).by(1)
        end

        it "redirects to the created fib" do
          post :create, params: {fib: valid_attributes}
          expect(response).to redirect_to(Fib.last)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { {space: 20} }

        before do
          @fib = Fib.create! valid_attributes
          @fib.generate && @fib.save
        end

        it "updates the requested fib" do
          expect(@fib.generated_fibs.size).to eq 10
          put :update, params: {id: @fib.to_param, fib: new_attributes}
          @fib.reload
          expect(@fib.generated_fibs.size).to eq 20
        end

        it "redirects to the fib" do
          put :update, params: {id: @fib.to_param, fib: valid_attributes}
          expect(response).to redirect_to(@fib)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested fib" do
        fib = Fib.create! valid_attributes
        expect {
          delete :destroy, params: {id: fib.to_param}
        }.to change(Fib, :count).by(-1)
      end

      it "redirects to the fibs list" do
        fib = Fib.create! valid_attributes
        delete :destroy, params: {id: fib.to_param}
        expect(response).to redirect_to(fibs_url)
      end
    end
  end
end
