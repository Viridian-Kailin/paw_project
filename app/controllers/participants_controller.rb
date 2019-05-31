class ParticipantsController < ApplicationController
  skip_before_action :admin, only: [:new, :create, :index, :show]
  #Grabs data entered into form fields and creates a new record.

  #Creates an entry with no proxy info / [:name][:phone][:email][:pref][:proxy]
  def new
    @members = Participant.new
  end

  def show
    @members = Participant.all.order(:badge)
    @members.length.times { |m|
      @members[m].as_json.each { |k,v|
        if v == "" || v == nil
          @members[m][k] = "NA"
        end
      }
    }
  end

  def update
    @member = Participant.find(params[:id])

    if @member.update_attributes(update_member)
      flash[:notice] = "Participant updated."
      redirect_to participants_total_url
    else
      flash[:alert] = "Unable to save edit."
      render 'edit'
    end
  end

  def edit
    @member = Participant.find(params[:id])
  end

  def create
    @members = Participant.new(member_params)

      if @members.save
        flash[:notice] = "#{@members.badge} has been added."
      else
        flash[:notice] = "#{@members.badge} already exists."
        render 'index'
      end
  end

  def destroy
    Participant.find(params[:id]).destroy
    flash[:notice] = "Participant has been deleted."
    redirect_to participants_total_url
  end

  private
  def member_params
    params.require(:member).permit(:badge,:name,:email,:phone,:pref,:proxy,:p_badge,:p_name,:p_phone,:p_email,:p_pref)
  end

  def update_member
    params.require(:participant).permit(:badge,:name,:email,:phone,:pref,:proxy,:p_badge,:p_name,:p_phone,:p_email,:p_pref)
  end
end