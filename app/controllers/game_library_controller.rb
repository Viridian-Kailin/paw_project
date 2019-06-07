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

    # Checks that a valid quantity was confirmed
    if library_params[:quantity_left] != nil && library_params[:quantity_left] != 99
      # If quantity is valid and "check in" was selected, checks the game in
      if params.has_key?(:checkin_game)

        if @checkstatus.save

          redirect_to "/game_library"
          flash[:notice] = "#{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} has been checked in by #{Participant.where(id: library_params[:participant_id]).pluck(:name)[0]}, badge #{Participant.where(id: library_params[:participant_id]).pluck(:badge)[0]}."
        else # If save fails, error is returned
          redirect_to "/game_library"
          flash[:notice] = @checkstatus.errors.full_messages
        end
      else # If quantity is valid and "check out" was selected, checks the game out

        if @checkstatus.save

          redirect_to "/game_library"
          flash[:notice] = "#{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} has been checked out by #{Participant.where(id: library_params[:participant_id]).pluck(:name)[0]}, badge #{Participant.where(id: library_params[:participant_id]).pluck(:badge)[0]}."
        else # If save fails, error is returned
          redirect_to "/game_library"
          flash[:notice] = @checkstatus.errors.full_messages
        end
      end
    # If check in was selected with a quantity matching the initial, warns about extra copies
    elsif library_params[:quantity_left] == 99
      redirect_to "/game_library"
      flash[:notice] = "Max number of copies for #{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} already checked in. Please ensure this is a PAW copy."
    else # If check out was selected with a quantity of 0, warns about no available copies
      redirect_to "/game_library"
      flash[:notice] = "No copies of #{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} available."
    end
  end

  def get_gameinfo
    @gameinfo = Inventory.find(params[:id])
    @gameschedule = Schedule.where(inventory_id: @gameinfo[:id])
    @librarylogs = Library.where(inventory_id: @gameinfo[:id])
    @staff = Hash.new

    @gameschedule.length.times do |i|
      if @gameschedule[i].paw_staff_id != nil
        @staff[i] = PawStaff.find(@gameschedule[i].paw_staff_id)[:name]
      else
        @staff[i] = "To be determined"
      end
    end

    @librarylogs.length.times do |i|
      @librarylogs[i][:participant_id] = Participant.find(@librarylogs[i].participant_id)[:badge]
    end

    render json: { :inventory => @gameinfo, :schedule => @gameschedule, :staff => @staff, :logs => @librarylogs}
  end

  def get_memberinfo
    @memberinfo = Participant.where(badge: params[:badge])

    render json: { member: @memberinfo}

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
    # Checking in a game
    if params.has_key?(:checkin_game) == true

      # Checks that the listed quantity against the total quantity
      if params[:library][:quantity_left].to_i < Inventory.find(params[:library][:inventory_id])[:quantity_total] # If listed is less than the total quantity, increase the quantity left

        @quantity = params[:library][:quantity_left]
        @quantity = @quantity.to_i + 1

        params.require(:library).permit(:inventory_id, :participant_id, :checked_in, :event_id, :quantity_left).merge(quantity_left: @quantity)
      else # If listed quantity matches or exceeds the total quantity, set quantity to enlarged number for error checking

        @quantity = 99

        params.require(:library).permit(:inventory_id, :participant_id, :checked_in, :event_id, :quantity_left).merge(quantity_left: @quantity)
      end
    # Check that "check out" was selected and that listed quantity is equal to the quantity total or not 0
    elsif params.has_key?(:checkin_game) == false && params[:library][:quantity_left].to_i == Inventory.find(params[:library][:inventory_id])[:quantity_total] || params[:quantity_left].to_i != 0 #if true, reduce the quantity left

      @quantity = params[:library][:quantity_left]
      @quantity = @quantity.to_i - 1

      params.require(:library).permit(:inventory_id, :participant_id, :checked_out, :event_id, :quantity_left).merge(quantity_left: @quantity)
    else # If "check in" was not selected and the quantity left is 0, return nil for error checking.

      @quantity = nil

      params.require(:library).permit(:inventory_id, :participant_id, :checked_out, :event_id, :quantity_left).merge(quantity_left: @quantity)
    end
  end

end