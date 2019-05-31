class PawStaffsController < ApplicationController
  skip_before_action :admin, only: [:show]

  def index
    @staff = PawStaff.all
  end

  def show
  end

  def new
    @staff = PawStaff.new()
  end

  def create
    @staff = PawStaff.new(staff_params)

    if @staff.save
      flash[:notice] = "#{@staff[:name]} has been added."
      redirect_to paw_staffs_path
    else
      flash[:alert] = "Unable to add #{@staff[:name]}."
      render 'new'
    end
  end

  def update
    @staff = PawStaff.find(params[:id])

    if @staff.update_attributes(staff_params)
      flash[:notice] = "Staff member updated."
      redirect_to paw_staffs_path
    else
      flash[:alert] = "Unable to save edit."
      render 'edit'
    end
  end

  def edit
    @staff = PawStaff.find(params[:id])
  end

  def destroy
    PawStaff.find(params[:id]).destroy
    flash[:notice] = "Staff member has been deleted."
    redirect_to paw_staffs_path
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
