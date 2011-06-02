class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  MAX_SESSION_TIME = 600

  public
  def login_required
    return false unless session[:fbid]
    true
  end
  
  def prepare_session
    unless !session[:expiry_time].nil?
      head 401
      return false
    end

    reset_session if session[:expiry_time] < Time.now
    session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
    true
  end
end
