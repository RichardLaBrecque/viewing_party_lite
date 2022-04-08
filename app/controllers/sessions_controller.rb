class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.find_by(email: params[:email])
      if  user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to "/dashboard"
      else
        flash[:error] = "INVALID PASSWORD"
        redirect_to '/login'
      end
    else
      flash[:error] = "Email Not Found"
      redirect_to '/login'
    end
  end

  def destroy
    session.destroy
  end
end
