class InventoryController < ApplicationController
  def new
    attr_writer :title, :company, :quantity_total
  end

  def update
    attr_accessor :quantity_total
  end

  def load_library
    attr_reader :title, :company, :quantity_total
  end
end
