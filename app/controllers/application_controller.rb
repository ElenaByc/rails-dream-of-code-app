class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_admin
    if session[:role] != 'admin'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_student
    if session[:role] != 'student'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_mentor
    if session[:role] != 'mentor'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_logged_in
    unless session[:user_id]
      flash[:alert] = 'You must be logged in to access that page'
      redirect_to login_path
    end
  end
end
