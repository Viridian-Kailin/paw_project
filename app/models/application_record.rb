# frozen_string_literal: true

#:nodoc:
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def admin?
    session[:user_name] == 'admin'
  end
end
