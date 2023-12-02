class ReservationsController < ApplicationController
  before_action :authenticate_user!
 
  def index
    @reservations = Current.user.reservations
    @rooms = Room.includes(:reservations).joins(:reservations).merge(Reservation.where(user: current_user))
  end

  def show
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)
    # ログイン中のユーザーのIDを設定
    @reservation.user_id = session[:user_id]

    if @reservation.valid?
      # 一時的に予約データをsessionに保存
      session[:reservation_start] = @reservation.start
      session[:reservation_end] = @reservation.end
      session[:reservation_people] = @reservation.people
      # 確認画面を表示する
      render "confirm"
    else
      # エラー時の処理  
      render "rooms/show" 
    end 
  end  

  def confirm
  end

  def confirm_create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = @room.reservations.build(
      start: session[:reservation_start], 
      end: session[:reservation_end],
      people: session[:reservation_people],
      user: current_user 
    )

    if @reservation.save
      flash[:notice] = "予約が成功しました。"
      redirect_to reservations_path
    else
      flash[:error] = "予約が失敗しました。入力項目を確認してください。"
      render :confirm
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = Room.find(@reservation.room_id)
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:notice] = "予約内容を更新しました。"
      redirect_to reservations_path
    else
      render "edit_reservation"
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    @current_user = Current.user
    # リダイレクト前に再度予約一覧を取得
    @reservations = Current.user.reservations 
    flash[:notice] = "予約を削除しました"
    redirect_to reservations_path 
  end
  
  private
  
  def reservation_params
    if params[:reservation].present?
      params.require(:reservation).permit(:start, :end, :people)
    else
      params.permit(:start, :end, :people, :room_id) 
    end
  end

end
