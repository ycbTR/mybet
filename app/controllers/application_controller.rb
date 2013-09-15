class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_current_user


  def set_current_user
    User.current = current_user
    @current_user = current_user
  end

  private

  def only_admin
    if user_signed_in?
      unless @current_user.has_role?('admin')
        redirect_to pending_bets_path and return
      end
    end
  end
end
