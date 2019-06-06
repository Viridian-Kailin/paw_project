class ApplicationController < ActionController::Base
before_action :authorize
before_action :admin
before_action :current_event

protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_path, alert: "Please log in"
    end
  end

  def admin
    unless session[:user_name] == "admin"
      redirect_to request.referrer, alert: "You need to be an admin."
    end
  end

  def current_event
    @event = Event.where(set: true)
    @event_info = @event.as_json
  end

end
