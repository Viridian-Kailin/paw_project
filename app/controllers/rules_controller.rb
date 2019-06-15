# frozen_string_literal: true

#:nodoc:
class RulesController < ApplicationController
  skip_before_action :admin
end
