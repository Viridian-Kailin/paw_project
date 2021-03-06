# frozen_string_literal: true

#:nodoc:
class ParticipantsController < ApplicationController
  skip_before_action :admin, only: %i[new create index show]
  # Grabs data entered into form fields and creates a new record.

  # Creates an entry with no proxy info / [:name][:phone][:email][:pref][:proxy]
  def new
    @members = Participant.new
  end

  def index
    @members = Participant.all.order(:badge)
    @members.length.times do |m|
      @members[m].as_json.each do |k, v|
        @members[m][k] = 'NA' if v == '' || v.nil?
      end
    end
  end

  def update
    @member = Participant.find(params[:id])

    if @member.update_attributes(update_member)
      flash[:notice] = 'Participant updated.'
      redirect_to participants_path
    else
      flash[:alert] = 'Unable to save edit.'
      render 'edit'
    end
  end

  def edit
    @test = params
    @member = Participant.find(params[:id])
  end

  def create
    @member = Participant.new(member_params)

    if @member.save
      flash.now[:notice] = "#{@member.badge} has been added."
    else
      flash.now[:alert] = "#{@member.badge} already exists."
    end

    render 'new'
  end

  def destroy
    Participant.find(params[:id]).destroy
    flash[:notice] = 'Participant has been deleted.'
    redirect_to participants_path
  end

  private

  def member_params
    params.require(:member).permit(:badge,
                                   :name,
                                   :email,
                                   :phone,
                                   :pref,
                                   :proxy,
                                   :p_badge,
                                   :p_name,
                                   :p_phone,
                                   :p_email,
                                   :p_pref)
  end

  def update_member
    params.require(:participant).permit(:badge,
                                        :name,
                                        :email,
                                        :phone,
                                        :pref,
                                        :proxy,
                                        :p_badge,
                                        :p_name,
                                        :p_phone,
                                        :p_email,
                                        :p_pref)
  end
end
