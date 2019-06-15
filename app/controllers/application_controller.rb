# frozen_string_literal: true

#:nodoc:
class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :admin
  before_action :current_event

  protected

  def authorize
    redirect_to login_path, alert: 'Please log in' unless User.find_by(id: session[:user_id])
  end

  def admin
    redirect_to request.referrer, alert: 'You need to be an admin.' unless session[:user_name] == 'admin'
  end

  def current_event
    @event = Event.where(set: true)
    @event_info = @event.as_json
  end
end
