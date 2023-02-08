class EventsController < ApplicationController
  before_action :logged_in?, except: [:index]

  def index
    @events = Event.all
    @upcomming_events = Event.upcoming
    @past_events = Event.past
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: 'Event was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendances = Attendance.where('status = ?', true).where('attended_event_id = ?', @event.id)
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location, :creator_id)
  end
end
