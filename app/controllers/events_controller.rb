# frozen_string_literal: true

#:nodoc:
class EventsController < ApplicationController
  skip_before_action :admin, only: [:show]
  before_action :event_id, only: %i[show edit update destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html do
          redirect_to events_path,
                      notice: 'Event was successfully created.'
        end
        format.json do
          render :show,
                 status: :created,
                 location: @event
        end
      else
        format.html { render :new }
        format.json do
          render json: @event.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def set_event
    @event = Event.find(params[:id])

    Event.update_all(set: false)
    Event.find(@event[:id]).update(set: true)
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    set_event
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html do
          redirect_to events_path,
                      notice: 'Event was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: @event
        end
      else
        format.html { render :edit }
        format.json do
          render json: @event.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html do
        redirect_to events_url,
                    notice: 'Event was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def event_id
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_code,
                                  :event_year,
                                  :event_location,
                                  :set)
  end
end
