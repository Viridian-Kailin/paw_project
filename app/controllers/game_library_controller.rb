# frozen_string_literal: true
#:nodoc:
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
      if !library_params[:quantity_left].nil? && library_params[:quantity_left] != 99
        # If quantity is valid and "check in" was selected, checks the game in
        if params.key?(:checkin_game)

          if @checkstatus.save

            redirect_to '/game_library'
            flash[:notice] = "#{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} has been checked in by #{Participant.where(id: library_params[:participant_id]).pluck(:name)[0]}, badge #{Participant.where(id: library_params[:participant_id]).pluck(:badge)[0]}."
          end
        # If quantity is valid and "check out" was selected, checks the game out
        else

          if @checkstatus.save

            redirect_to '/game_library'
            flash[:notice] = "#{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} has been checked out by #{Participant.where(id: library_params[:participant_id]).pluck(:name)[0]}, badge #{Participant.where(id: library_params[:participant_id]).pluck(:badge)[0]}."
          end
        end
      # If check in was selected with a quantity matching the initial, warns about extra copies
      elsif library_params[:quantity_left] == 99
        redirect_to '/game_library'
        flash[:notice] = "Max number of copies for #{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} already checked in. Please ensure this is a PAW copy."
      # If check out was selected with a quantity of 0, warns about no available copies
      else
        redirect_to '/game_library'
        flash[:notice] = "No copies of #{Inventory.where(id: library_params[:inventory_id]).pluck(:title)[0]} available."
      end
  end

  def gameinfo
    @gameinfo = Inventory.find(params[:id])
    @gameschedule = Schedule.where(inventory_id: @gameinfo[:id])
    @librarylogs = Library.where(inventory_id: @gameinfo[:id])
    @staff = {}

    @gameschedule.length.times do |i|
      @staff[i] = if !@gameschedule[i].paw_staff_id.nil?
                    PawStaff.find(@gameschedule[i].paw_staff_id)[:name]
                  else
                    'To be determined'
                  end
    end

    @librarylogs.length.times do |i|
      @librarylogs[i][:participant_id] = Participant.find(@librarylogs[i].participant_id)[:badge]
    end

    render json: { inventory: @gameinfo, schedule: @gameschedule, staff: @staff, logs: @librarylogs }
  end

  def memberinfo
    @memberinfo = Participant.where(badge: params[:badge])

    render json: { member: @memberinfo }
  end

  class << self
    private

    def human_attribute_name(attr, _options = {})
      attr
    end

    def lookup_ancestors
      [self]
    end
  end

  private

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def library_params
    # Checking in a game
    if params.key?(:checkin_game) == true
      # Checks that the listed quantity is less than the total
      if params[:library][:quantity_left].to_i < Inventory.find(params[:library][:inventory_id])[:quantity_total]

        @quantity = params[:library][:quantity_left]
        @quantity = @quantity.to_i + 1
      # Otherwise, set large for error checking
      else
        @quantity = 99
      end

      params.require(:library).permit(:inventory_id, :participant_id, :checked_in, :event_id, :quantity_left).merge(quantity_left: @quantity)
    # Checking out a game that has quantity left
    elsif params[:library][:quantity_left].to_i == Inventory.find(params[:library][:inventory_id])[:quantity_total] && params[:quantity_left].to_i > -1

      @quantity = params[:library][:quantity_left]
      @quantity = @quantity.to_i - 1

      params.require(:library).permit(:inventory_id, :participant_id, :checked_out, :event_id, :quantity_left).merge(quantity_left: @quantity)
    # If "check in" was not selected and the quantity left is 0, return nil for error checking.
    else
      @quantity = nil

      params.require(:library).permit(:inventory_id, :participant_id, :checked_out, :event_id, :quantity_left).merge(quantity_left: @quantity)
    end
  end
end
