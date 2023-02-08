class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end

  def logged_in?
    redirect_to '/sign_in' unless current_user
  end

  def invited?(user, event)
    user.attended_events.exists?(event)
  end
  helper_method :invited?

  def attended?(user, event)
    user.attendances.where('attended_event_id = ?', event).first.status
  end
  helper_method :attended?
end
