class InventoriesController < ApplicationController
  skip_before_action :admin, only: [:index]

  def index
    @games = Inventory.all.order(:title)
  end

  def show
    @games = Inventory.all.order(:title)
  end

  def new
    @game = Inventory.new()
  end

  def edit
    @game = Inventory.find(params[:id])
  end

  def create
    @game = Inventory.new(game_params)

    if @game.save
      flash[:notice] = "Game has been added."
      redirect_to inventories_path
    else
      flash[:alert] = "Something went wrong."
      render 'new'
    end
  end

  def update
    @game = Inventory.find(params[:id])

    if @game.update_attributes(game_params)
      flash[:notice] = "Game updated."
      redirect_to inventories_path
    else
      flash[:alert] = "Unable to save edit."
      render 'edit'
    end
  end

  def destroy
    Inventory.find(params[:id]).destroy
    flash[:notice] = "Game has been deleted."
    redirect_to inventories_path
  end

  private

  def game_params
    params.require(:inventory).permit(:title, :company, :quantity_total)
  end

end
