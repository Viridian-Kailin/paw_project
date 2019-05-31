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
    @staff = PawStaff.find(params[:id])

    if @staff.update_attributes(staff_params)
      flash[:notice] = "Staff member updated."
      redirect_to paw_staff_index_path
    else
      flash[:alert] = "Unable to save edit."
      render 'edit'
    end
  end

  def edit
    @staff = PawStaff.find(params[:id])
  end

  def destroy
  end

  private

  def staff_params
    params[:paw_staff].as_json.each { |k,v|
      if v == ""
        params[:paw_staff][k] = "NA"
      end
    }

    params.require(:paw_staff).permit(:name, :badge, :phone, :email, :title, :role)
  end

end
