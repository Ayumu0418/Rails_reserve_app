class ReservationsController < ApplicationController
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
  
    if @reservation.save
      redirect_to root_path, notice: '予約が成功しました。'
    else
      render "rooms/show"
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = Room.find(@reservation.room_id)
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params_for_edit)
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
    params.permit(:start, :end, :people) 
  end

  def reservation_params_for_edit
    params.require(:reservation).permit(:start, :end, :people) 
  end
  
end
