class GameLibraryController < ApplicationController
  skip_before_action :admin

  def index
    @gameinfo = Inventory.all
  end

  def new
    @checkstatus = Library.new
  end

  def create
    @checkstatus = Library.new(library_params)

    #binding.pry

    if library_params[:quantity_left] != nil && library_params[:quantity_left] != 99
      if params.has_key?(:checkin_game)
        if @checkstatus.save
          redirect_to "/game_library"
          flash[:notice] = "#{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} has been checked in by #{Participant.where(id: library_params[:participant_id]).pluck(:name)[0]}, badge #{Participant.where(id: library_params[:participant_id]).pluck(:badge)[0]}."
        else
          redirect_to "/game_library"
          flash[:notice] = @checkstatus.errors.full_messages
        end
      else
        if @checkstatus.save
          redirect_to "/game_library"
          flash[:notice] = "#{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} has been checked out by #{Participant.where(id: library_params[:participant_id]).pluck(:name)[0]}, badge #{Participant.where(id: library_params[:participant_id]).pluck(:badge)[0]}."
        else
          redirect_to "/game_library"
          flash[:notice] = @checkstatus.errors.full_messages
        end
      end
    elsif library_params[:quantity_left] == 99
      redirect_to "/game_library"
      flash[:notice] = "Max number of copies for #{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} already checked in. Please ensure this is a PAW copy."
    else
      redirect_to "/game_library"
      flash[:notice] = "No copies of #{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} available."
    end
  end

  def get_gameinfo
    # Pull up game info
    @gameinfo = Inventory.all.where(id: params[:id])
    # Pull up game schedule
    @gameschedule = Schedule.all.where(inventory_id: @gameinfo[0].id)
    # Pull up all staff listed in schedule
    @staff = Hash.new
    @gameschedule.length.times do |i|
      @staff[i] = PawStaff.where(id: @gameschedule[i].paw_staff_id).pluck(:name)
    end
    # Pull up library history
    @librarylogs = Library.all.where(inventory_id: @gameinfo[0].id)
    # Pull up participant info for library history
    @memberinfo = Hash.new
    @librarylogs.length.times do |i|
      @memberinfo[i] = Participant.where(id: @librarylogs[i].participant_id)
    end
    # Send all to view
    render json: { :inventory => @gameinfo, :schedule => @gameschedule, :staff => @staff, :logs => @librarylogs, :memberinfo => @memberinfo }
  end

  def get_memberinfo
    @memberinfo = Participant.where(badge: params[:badge])

    render json: { :member => @memberinfo }
  end

  private

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end

  def library_params
    if params.has_key?(:checkin_game) == true
      if params[:library][:quantity_left].to_i < Library.where(inventory_id: params[:library][:inventory_id]).pluck(:quantity_left)[0].to_i

        @quantity = params[:library][:quantity_left]
        @quantity = @quantity.to_i + 1

        params.require(:library).permit(:inventory_id, :participant_id, :checked_in, :quantity_left).merge(quantity_left: @quantity)
      else
        @quantity = 99

        params.require(:library).permit(:inventory_id, :participant_id, :checked_in, :quantity_left).merge(quantity_left: @quantity)
      end
    elsif params.has_key?(:checkin_game) == false && params[:library][:quantity_left].to_i >= Library.where(inventory_id: params[:library][:inventory_id]).pluck(:quantity_left)[0].to_i

      @quantity = params[:library][:quantity_left]
      @quantity = @quantity.to_i - 1

      params.require(:library).permit(:inventory_id, :participant_id, :checked_out, :quantity_left).merge(quantity_left: @quantity)

    else
      @quantity = nil

      params.require(:library).permit(:inventory_id, :participant_id, :checked_out,:quantity_left).merge(quantity_left: @quantity)
    end
  end

end