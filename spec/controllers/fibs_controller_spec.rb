require 'rails_helper'

RSpec.describe FibsController, type: :controller do
  let(:valid_params)      { {max_number:  5} }
  let(:valid_get_params)  { {id: @fib.id} }
  let(:post_valid_params) { {fib: {max_number:  5}} }
  let(:put_valid_params)  { {id: @fib.id, fib: {max_number:  5}} }
  let(:invalid_get_params)  { {id: @fib.id + 1} }
  let(:put_invalid_params)  { {id: @fib.id + 1, fib: {max_number:  5}} }

  context "successfull actions" do
    before do
      @fib = Fib.new
      @fib.set_values(valid_params[:max_number])
      @fib.save
    end

    it "get index page successfully" do
      get :index
      expect(response).to be_success
    end

    it "get show page successfully" do
      get :show, params: valid_get_params
      expect(response).to be_success
    end

    it "get edit page successfully" do
      get :edit, params: valid_get_params
      expect(response).to be_success
    end

    it "get new page successfully" do
      get :new
      expect(response).to be_success
    end

    it "create fibo successfully" do
      post :create, params: post_valid_params
      expect(response).to redirect_to(fib_path(Fib.last.id))
      expect(Fib.count).to be(2)
    end

    it "update fibo successfully" do
      put :update, params: put_valid_params
      expect(response).to redirect_to(fib_path(Fib.last.id))
      expect(Fib.count).to be(1)
    end

    it "delete fibo successfully" do
      delete :destroy, params: valid_get_params
      expect(response).to redirect_to(fibs_path)
      expect(Fib.count).to be(0)
    end

  end

  context "unsuccessfull actions" do
    before do
      @fib = Fib.new
      @fib.set_values(valid_params[:max_number])
      @fib.save
    end

    it "get show page unsuccessfully" do
      expect do
        get :show, params: invalid_get_params
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "get edit page unsuccessfully" do
      expect do
        get :edit, params: invalid_get_params
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "update page unsuccessfully" do
      expect do
        put :update, params: put_invalid_params
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "delete page unsuccessfully" do
      expect do
        delete :destroy, params: invalid_get_params
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
