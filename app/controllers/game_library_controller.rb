class GameLibraryController < ApplicationController

  def index
    @gameinfo = Inventory.all
  end

  def new
    @checkstatus = Library.new
  end

  def create
    @checkstatus = Library.new(library_params)

    if params.has_key?(:checkin_game)
      if @checkstatus.save
        redirect_to "/game_library"
        flash[:notice] = "#{@checkstatus[:title]} has been checked in by #{@checkstatus[:badge]}."
      else
        render :show
      end
    else
      if @checkstatus.save
        redirect_to "/game_library"
        flash[:notice] = "#{@checkstatus[:title]} has been checked out by #{@checkstatus[:badge]}."
      else
        render :show
      end
    end
  end

  def check_in
    @check_quantity = Library.where(inventory_id: params[:library][:inventory_id]).pluck(:quantity_left).last

    if @check_quantity != null
      @checkstatus = Library.new(checkin_params)

      if @checkstatus.save
        redirect_to "/game_library"
        flash[:notice] = "#{@checkstatus[:title]} has been checked in by #{@checkstatus[:badge]}."
      else
        render :show
      end
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
    if params[:checkin_game]
      @quantity = params[:library][:quantity_left]
      @quantity = @quantity.to_i + 1

      params.require(:library).permit(:inventory_id, :participant_id, :checked_in).merge(quantity_left: @quantity)
    else
      @quantity = params[:library][:quantity_left]
      @quantity = @quantity.to_i - 1

      params.require(:library).permit(:inventory_id, :participant_id, :checked_out).merge(quantity_left: @quantity)
    end
  end

end