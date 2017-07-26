class FibsController < ApplicationController
  before_action :set_fib, only: [:show, :edit, :update, :destroy]

  def index
    @fibs = Fib.all
  end

  def show
  end

  def new
    @fib = Fib.new
  end

  def edit
  end

  def create
    @fib = Fib.new(fib_params)

    respond_to do |format|
      if @fib.generate && @fib.save
        format.html { redirect_to @fib, notice: 'Fib was successfully created.' }
        format.json { render :show, status: :created, location: @fib }
      else
        format.html { render :new }
        format.json { render json: @fib.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fib.update_attributes(fib_params)
        @fib.generate && @fib.save
        format.html { redirect_to @fib, notice: 'Fib was successfully updated.' }
        format.json { render :show, status: :ok, location: @fib }
      else
        format.html { render :edit }
        format.json { render json: @fib.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fib.destroy
    respond_to do |format|
      format.html { redirect_to fibs_url, notice: 'Fib was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_fib
    @fib = Fib.find(params[:id])
  end

  def fib_params
    params.require(:fib).permit(:space)
  end
end
