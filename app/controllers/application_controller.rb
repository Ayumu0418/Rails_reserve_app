class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  before_action :set_no_cache
  before_action :set_current_user
  # アクション実行前にset_current_userメソッドを呼び出す

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def current_user
    Current.user
  end

  def user_signed_in?
    !Current.user.nil?
  end

  def authenticate_user!
    redirect_to login_url unless user_signed_in?
  end

  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end