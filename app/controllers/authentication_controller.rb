class AuthenticationController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "Username / Password invalid"
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

end
