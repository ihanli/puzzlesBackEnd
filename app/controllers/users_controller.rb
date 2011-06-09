class UsersController < ApplicationController
 # skip_filter :login_required
  before_filter :prepare_session, :except => [:show, :destroy]
  before_filter :find_user, :only => [:show, :destroy]

  def show
    respond_to do |format|
      format.xml
    end
  end

  def create
    user = User.new(params[:user].to_i)
    if user.save
      redirect_to user_path(user.id)
    else
      head 500
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path
    else
      head 500
    end
  end

  def register_and_login
    User.find_or_create_by_fb_id(params[:id].to_i)
    session[:fbid] = params[:id].to_i
    session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
    head 200
  end

  protected
  def find_user
    @user = User.find_by_id(params[:id])
  end
end