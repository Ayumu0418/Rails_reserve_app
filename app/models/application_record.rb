class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # ApplicationRecordは抽象クラスであるということ（=このクラスはデータベースのテーブルに直接関連付けられていない）。他のモデルがこのクラスを継承することで、共通の機能やメソッドを利用できる。

  def user_login_required
    unless Current.user
        flash[:warning] = "ログインしてから操作を行なってください。"
        redirect_to login_path
    end
  end
  # Current.userがnilの場合（ログインしていない）、ログインページにリダイレクトすることで、ログインが必要な操作を不正に行うことを防止する。
end
