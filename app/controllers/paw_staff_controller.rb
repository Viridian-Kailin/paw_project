class PawStaffController < ApplicationController
  skip_before_action :admin, only: [:show]

  def index
    @staff = PawStaff.all
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
    @staff = PawStaff.find(params[:id])
    @test = params[:id] ||= "empty"
  end

  def destroy
  end

  private

  def staff_params
    require.params[:id]
  end

end
