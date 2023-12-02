class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def user_login_required
    unless Current.user
        flash[:warning] = "ログインしてから操作を行なってください。"
        redirect_to login_path
    end
  end

end
