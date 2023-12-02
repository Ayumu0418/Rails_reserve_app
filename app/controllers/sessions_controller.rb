class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      Current.user = user
      flash[:success] = "ログインしました。"
      redirect_to root_path
    elsif params[:email].blank? && params[:password].blank?
      @user = User.new
      @user.errors.add(:email, "を入力してください")
      @user.errors.add(:password, "を入力してください")
      render :new
    elsif params[:email].blank?
      @user = User.new(email: params[:email]) 
      @user.errors.add(:email, "が正しくありません")
      render :new
    elsif params[:password].blank?
      @user = User.new(password: params[:password]) 
      @user.errors.add(:password, "が正しくありません")
      render :new
    else
      @user = User.new
      @user.errors.add(:email, "かパスワードに誤りがあります")
      @user.errors.add(:password, "かメールアドレスに誤りがあります")
      render :new
    end
  end

  def destroy
    reset_session
    Current.user = nil

    session[:user_id] = nil
    # user_IDリセット※↑追加でdestroyアクション正常動作

    flash[:success] = "ログアウトしました。"
    redirect_to root_path(logout: true) 
  end

end
