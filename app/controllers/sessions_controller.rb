# frozen_string_literal: true

#:nodoc:
class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :admin

  def create
    user = User.find_user(params[:username])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.username
      redirect_to root_path
    else
      redirect_to login_path, alert: 'Invalid username/password combination.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, alert: 'Logged out'
  end
end
