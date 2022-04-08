# frozen_string_literal: true

class ApplicationController < ActionController::Base
    add_flash_types :success, :warning, :danger, :info
    helper_method :current_user

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end

    def require_user
    if !current_user
      flash[:alert] = 'you must be logged in'
      redirect_to '/login'
    end
  end
end
