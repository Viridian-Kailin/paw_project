class ParticipantsController < ApplicationController
  #Grabs data entered into form fields and creates a new record.

  #Creates an entry with no proxy info / [:name][:phone][:email][:pref][:proxy]
  def new
    @members = Participant.new
  end

  def create
    @members = Participant.new(member_params)

      if @members.save
        flash[:notice] = "#{@members.badge} has been added."
        render 'index'
      else
        flash[:notice] = "#{@members.badge} already exists."
        render 'index'
      end
  end

  private
  def member_params
    params.require(:member).permit(:badge,:name,:email,:phone,:pref,:proxy,:p_badge,:p_name,:p_phone,:p_email,:p_pref)
  end
=begin
  #If participant provided proxy info, this now gets added
  #def addproxy
    #attr_writer :badge, :proxy, :p_badge, :p_name, :p_phone, :p_email, :p_pref
  #end

    if @members.save
      flash[:notice] = "#{@members.name} was successfully added!"
      redirect_to "/participants"
    end
=end
end
