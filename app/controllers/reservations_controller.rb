class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
    @rooms = Room.with_attached_hotel_image.all
  
    if params[:room_id].present?
      @room = Room.find_by(id: params[:room_id])
      if @room.nil?
        # 該当する Room が見つからない場合の処理
        puts "Room not found for ID: #{params[:room_id]}"
      else
        puts "Room ID: #{params[:room_id]}"
        puts "Room: #{@room.inspect}"
      end
    else
      # params[:room_id] が存在しない場合の処理
      puts "Room ID not present"
    end
  end

  def show
    @reservation = Reservation.new 
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)
  
    if [:start, :end, :people].any? { |attr| reservation_params[attr].blank? }
        flash[:error] = "全ての項目を入力してください。"
        puts "DEBUG: 空欄の場合"
        render "rooms/show"
    elsif @reservation.save
        # 保存が成功した場合、確認画面を表示する
        puts "DEBUG: 保存成功"
        render "confirm"
    else
        flash[:error] = "予約に失敗しました。入力項目を確認してください。"
        puts "DEBUG: 保存失敗"
        render "rooms/show"
    end
  end

  def confirm
    # 確認画面の表示
  end

  def confirm_create
    # 確認画面からの保存ボタンが押されたときに実行されるアクション
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build(reservation_params)

    if @reservation.save
      redirect_to root_path, notice: '予約が成功しました。'
    else
      render :new
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
    flash[:notice] = "予約を削除しました"
    redirect_to reservations_path
  end
  
  private
  
  def reservation_params
    if params[:reservation].present?
      params.require(:reservation).permit(:start, :end, :people)
    else
      params.permit(:start, :end, :people) 
    end
  end


end
