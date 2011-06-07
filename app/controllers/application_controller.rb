class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :prepare_session

  MAX_SESSION_TIME = 600

  def login_required
    unless session[:fbid]
      head 401
      false
    end
    true
  end

  protected
  def prepare_session
     if !session[:expiry_time].nil? and session[:expiry_time] < Time.now
        reset_session
     end

     session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
     return true
  end
#  def prepare_session
#    if session[:expiry_time].nil?
#      head 401
#      return false
#    end
#
#    reset_session if session[:expiry_time] < Time.now
#    session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
#    true
#  end
end
