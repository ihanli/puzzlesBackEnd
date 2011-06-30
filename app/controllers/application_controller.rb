class ApplicationController < ActionController::Base
  protect_from_forgery

  MAX_SESSION_TIME = 600

  def login_required
    unless session[:fbid]
      head 401
      false
    end
    true
  end

  def prepare_session
     if !session[:expiry_time].nil? and session[:expiry_time] < Time.now.utc
        reset_session
     end

     session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
     return true
  end
end
