class UsersController < ApplicationController
  before_filter :find_user, :only => [:show, :destroy]

  def show
    respond_to do |format|
      format.xml
    end
  end

  def create
    user = User.new(params[:user])
    redirect_to user_path(user.id) if user.save
    head 500
  end

  def destroy
    redirect_to users_path if @user.destroy
    head 500
  end

  protected
  def find_user
    @user = User.find_by_id(params[:id])
  end
end