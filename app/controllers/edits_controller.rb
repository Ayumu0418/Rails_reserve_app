class EditsController < ApplicationController
  before_action :user_login_required

  # ※このコントローラーは使用しない

  def edit

  end

  def update
      if Current.user.update(account_params)
        SessionsController.action(:destroy).call
        flash[:success] = "アカウント情報が更新されました。もう一度ログインをお願いします。"
        redirect_to login_path(logout: true) 

      else
          flash[:danger] = "アカウント情報の更新が失敗しました。もう一度試してください。"
          render :edit, status: :unprocessable_entity
      end
   
  end

  private

  def account_params
      params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def test_params
    params.require(:user).permit(:text, :image)
  end
end
