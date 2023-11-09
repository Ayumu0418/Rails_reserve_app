class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      Current.user = user
      flash[:success] = "ログインしました。"
      redirect_to root_path
    else
      flash[:danger] = "ログインに失敗しました。もう一度試してください。"
      render :new
    end
  end

  def destroy
    reset_session
    Current.user = nil
    session[:user_id] = nil

    flash[:success] = "ログアウトしました。"
    redirect_to root_path
  end
end
