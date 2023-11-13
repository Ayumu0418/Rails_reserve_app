class ApplicationController < ActionController::Base
  
  before_action :set_current_user
  # アクション実行前にset_current_userメソッドを呼び出す

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
      # もしsessionにuser_idが存在する場合、そのuser_idに対応するUserモデルのインスタンスをCurrentクラスにセットする。
      # →他のコントローラーやビューでCurrent.userを使用することで、現在のログインユーザーに関する情報にどこからでもアクセスできる（現在のユーザーのセッションを維持するため）。
  end
end