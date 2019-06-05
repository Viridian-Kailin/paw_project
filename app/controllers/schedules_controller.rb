class SchedulesController < ApplicationController
  skip_before_action :admin, only: [:index]

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      flash[:notice] = "Scheduled game has been added."
      redirect_to schedules_path
    else
      flash[:alert] = "Something went wrong."
      render 'new'
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])

    if @schedule.update_attributes(schedule_params)
      flash[:notice] = "Scheduled game has been updated."
      redirect_to schedules_path
    else
      flash[:alert] = "Unable to save edit."
      render 'edit'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id]).destroy
    flash[:notice] = "Scheduled game has been deleted."
    redirect_to schedules_path
  end

  def index
    @schedule = Schedule.all.order(:inventory_id)
    @schedule_info = Array.new
    @schedule_details = Array.new

    @schedule.length.times { |i|
      if @schedule[i][:paw_staff_id] != nil
        @schedule_info[i] = {
          id: @schedule[i][:id],
          inventory_id: @schedule[i][:inventory_id],
          paw_staff_id: @schedule[i][:participant_id],
          title: Inventory.where(id: @schedule[i][:inventory_id])[0][:title],
          staff_member: PawStaff.where(id: @schedule[i][:paw_staff_id])[0][:name],
          start: @schedule[i][:start],
          end: @schedule[i][:end],
          location: @schedule[i][:location]
        }
      else
        @schedule_info[i] = {
          id: @schedule[i][:id],
          inventory_id: @schedule[i][:inventory_id],
          paw_staff_id: @schedule[i][:participant_id],
          title: Inventory.where(id: @schedule[i][:inventory_id])[0][:title],
          staff_member: "Pending",
          start: @schedule[i][:start],
          end: @schedule[i][:end],
          location: @schedule[i][:location]
        }
      end
    }
  end

  private

  def schedule_params
    params.require(:schedule).permit(:inventory_id, :location, :paw_staff_id, :start, :end)
  end
end
