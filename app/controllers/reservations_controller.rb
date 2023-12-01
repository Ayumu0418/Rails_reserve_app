class ReservationsController < ApplicationController
  before_action :authenticate_user!
 
  def index
    @reservations = Current.user.reservations
    @rooms = Room.with_attached_hotel_image.all
  
    if params[:room_id].present?
      @room = Room.find_by(id: params[:room_id])
      if @room.nil?
        # 該当する Room が見つからない場合の処理
        puts "該当のRoom IDが見つかりませんでした ID: #{params[:room_id]}"
      else
        puts "Room ID: #{params[:room_id]}"
        puts "Room: #{@room.inspect}"
      end
    else
      puts "Room IDが存在しません。"
      # params[:room_id] が存在しない場合の処理
    end
  end

  def show
    @reservation = Reservation.new 
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user_id = session[:user_id]
     # ログイン中のユーザーのIDを設定
    
     puts "DEBUG: reservation_params = #{reservation_params}"



    if @reservation.valid?
      session[:reservation_start] = @reservation.start
      # 一時的に予約データをsessionに保存
      session[:reservation_start] = @reservation.start
      session[:reservation_end] = @reservation.end
      session[:reservation_people] = @reservation.people

      puts "DEBUG: sessionに予約データを一時的に保存しました。"
      puts "DEBUG: @reservation: #{@reservation.inspect}"
      puts "DEBUG: session[:reservation_start] = #{session[:reservation_start]}"
      puts "DEBUG: session[:reservation_end] = #{session[:reservation_end]}"
      puts "DEBUG: session[:reservation_people] = #{session[:reservation_people]}"

      # 確認画面を表示する
      render "confirm"
  
    else
      # エラー時の処理  
      render "rooms/show" 
    end
      
  end
  
  
  def confirm
    # 確認画面の表示
    puts "DEBUG: def confirmが実行されました。"
  end

  def confirm_create
    @room = Room.find(params[:reservation][:room_id])
      puts "DEBUG: def confirm_createが実行されました。"
      puts "DEBUG: session[:reservation_start] = #{session[:reservation_start]}"
      puts "DEBUG: session[:reservation_end] = #{session[:reservation_end]}"
      puts "DEBUG: session[:reservation_people] = #{session[:reservation_people]}"

    @reservation = @room.reservations.build(
      start: session[:reservation_start], 
      end: session[:reservation_end],
      people: session[:reservation_people],
      user: current_user 
    )

    if @reservation.save
      flash[:notice] = "予約が成功しました。"
      puts "DEBUG: 予約が成功しました。"
      redirect_to reservations_path
    else
      flash[:error] = "予約が失敗しました。入力項目を確認してください。"
      puts "DEBUG: 予約が失敗しました。"
      puts "DEBUG: エラーメッセージ: #{@reservation.errors.full_messages}"
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
