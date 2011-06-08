class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :login_required

  MAX_SESSION_TIME = 600

  protected
  def login_required
    unless session[:fbid]
      head 401
      false
    end
    true
  end

  def prepare_session
     if !session[:expiry_time].nil? and session[:expiry_time] < Time.now
        reset_session
     end

     session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
     return true
  end
end
