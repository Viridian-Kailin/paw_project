class GameLibraryController < ApplicationController

  def new

    @checkstatus = Library.new

  end

  def create

    @checkstatus = Library.new(library_params)

    if @checkstatus.save

      redirect_to "/participants"

    else

      render :show

    end

  end

  private

  def library_params

    params.require(:library).permit(:title, :badge)

  end

end