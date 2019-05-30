class ApplicationController < ActionController::Base
before_action :authorize
before_action :admin

protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_path, alert: "Please log in"
    end
  end

  def admin
    unless User.find_by(username: session[:user_name]) == "admin"
      redirect_to request.referrer, alert: "You need to be an admin."
    end
  end

end
