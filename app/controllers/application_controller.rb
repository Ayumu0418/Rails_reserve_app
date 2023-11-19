class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  before_action :set_current_user
  # アクション実行前にset_current_userメソッドを呼び出す

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
      # もしsessionにuser_idが存在する場合、そのuser_idに対応するUserモデルのインスタンスをCurrentクラスにセットする。
      # →他のコントローラーやビューでCurrent.userを使用することで、現在のログインユーザーに関する情報にどこからでもアクセスできる（現在のユーザーのセッションを維持するため）。
  end

  def user_signed_in?
    !Current.user.nil?
  end

  def authenticate_user!
    redirect_to login_url unless user_signed_in?
  end

end