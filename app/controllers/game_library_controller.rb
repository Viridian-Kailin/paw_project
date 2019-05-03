class GameLibraryController < ApplicationController

  def index
    @gameinfo = Inventory.all
  end

  def new
    @checkstatus = Library.new
  end

  def create
    @checkstatus = Library.new(library_params)

    if @checkstatus.save
      redirect_to "/game_library"
      flash[:notice] = "#{@checkstatus[:title]} has been checked out by #{@checkstatus[:badge]}."
    else
      render :show
    end
  end

  def get_gameinfo
    @gameinfo = Inventory.all.where(title: params[:title])
    render json: @gameinfo

  end

  private

  def library_params
    params.require(:library).permit(:title, :badge)
  end

end