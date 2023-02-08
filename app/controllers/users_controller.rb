class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :logged_in?, only: %i[attend_events withdraw_events invite_user cancel_invite_user]

  def index
    @users = User.where('id != ?', current_user.id).order('name ASC')
    @event = Event.find(params[:event_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:current_user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was Successfully created' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @created_event = @user.events
    @upcoming = Event.upcoming.select do |event|
      event.attendances.where('status = ?', true).where('attendee_id = ?', @user.id)
    end
    @past = Event.past.select do |event|
      event.attendances.where('status = ?', true).where('attendee_id = ?', @user.id)
    end
  end

  def attend_events
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @attendance = @user.attendances.where('attended_event_id = ?', @event.id).first
    @attendance.status = true
    @attendance.save
    flash.notice = 'Invitation Accepted!'
    redirect_to '/'
  end

  def withdraw_events
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @attendance = @user.attendances.where('attended_event_id = ?', @event.id).first
    @attendance.status = false
    @attendance.save
    flash.notice = 'Event Cancelled!'
    redirect_to '/'
  end

  def invite_user
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.attendances.create(attended_event: @event)
    flash.notice = "Invitation sent to #{@user.name} !"
    redirect_to "/inviteUsers/#{@event.id}"
  end

  def cancel_invite_user
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    @user.attended_events.delete(@event)
    flash.notice = "Invitation cancelled for #{@user.name} !"
    redirect_to "/inviteUsers/#{@event.id}"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user; end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end
end
