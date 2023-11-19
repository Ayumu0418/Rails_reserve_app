class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def signup

  end 

  def edit
  end

  def update
    if Current.user.authenticate(params[:user][:current_password]) && Current.user.update(account_params)
      reset_session
      Current.user = nil
      session[:user_id] = nil
      flash[:success] = "アカウント情報が更新されました。もう一度ログインをお願いします。"
      redirect_to login_path(logout: true) 

    else
        flash[:danger] = "アカウント情報の更新が失敗しました。もう一度試してください。"
        render :edit, status: :unprocessable_entity
    end
  end

  def update_profile
    if Current.user.update(profile_params)
      flash[:success] = "プロフィールが更新されました。"
      redirect_to profile_path
    else
      flash[:danger] = "プロフィールの更新が失敗しました。もう一度試してください。"
      render :edit, status: :unprocessable_entity
    end
  end

  private
    
    def profile_params
      params.require(:user).permit(:image, :user_name, :introduction)
    end

    def account_params
      if params[:user][:email].present?
        params.require(:user).permit(:email, :password, :password_confirmation)
      else
        params.require(:user).permit(:password, :password_confirmation)
      end
    end

end
