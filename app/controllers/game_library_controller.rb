class GameLibraryController < ApplicationController

  def index
    @gameinfo = Inventory.all
  end

  def new
    @checkstatus = Library.new
  end

  def create
    @checkstatus = Library.new(library_params)

    if @checkstatus.save
      redirect_to "/game_library"
      flash[:notice] = "#{@checkstatus[:title]} has been checked out by #{@checkstatus[:badge]}."
    else
      render :show
    end
  end

  def check_in
    @checkstatus = Library.new(checkin_params)

    if @checkstatus.save
      redirect_to "/game_library"
      flash[:notice] = "#{@checkstatus[:title]} has been checked out by #{@checkstatus[:badge]}."
    else
      render :show
    end
  end

  def get_gameinfo
    @gameinfo = Inventory.all.where(id: params[:id])
    @gameschedule = Schedule.all.where(inventory_id: @gameinfo[0].id)
    @staff = PawStaff.all
    @librarylogs = Library.all.where(inventory_id: @gameinfo[0].id)
    render json: { :inventory => @gameinfo, :schedule => @gameschedule, :staff => @staff, :logs => @librarylogs }
  end

  private

  def library_params
    @logs_timestamp = DateTime.new(params[:library]["checked_out(1i)"].to_i,params[:library]["checked_out(2i)"].to_i,params[:library]["checked_out(3i)"].to_i,params[:library]["checked_out(4i)"].to_i,params[:library]["checked_out(5i)"].to_i)

    if params[:checkin_game]
       params.require(:library).permit(:inventory_id, :participant_id).merge(checked_in: @logs_timestamp)
    else
      params.require(:library).permit(:inventory_id, :participant_id).merge(checked_out: @logs_timestamp)
    end
  end

end