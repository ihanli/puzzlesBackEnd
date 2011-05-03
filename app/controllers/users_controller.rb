class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
      
    respond_to do |format|
      format.xml
    end
  end
  
  def create
    @user = User.new(params[:user])
      
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :status => 500
    end
  end
  
  def destroy
    @user = User.find(params[:id])
        
    if @user.destroy
      redirect_to users_path
    else
      render :status => 500
    end
  end
end
