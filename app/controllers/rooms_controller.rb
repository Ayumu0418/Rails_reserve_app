class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new_room, :create]

  def index
    @rooms = Room.with_attached_hotel_image.all
  end

  def myroom_index
    @myrooms = current_user.rooms.with_attached_hotel_image
  end

  def new_room
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(room_params)

    if params[:room][:hotel_image].present?
      @room.hotel_image.attach(params[:room][:hotel_image])
    end

    if @room.save
        redirect_to root_path, notice: "新しい施設を作成しました。"
    else
      render :new_room
    end
  end
    
  def search
    @rooms = Room.search(params[:keyword_free], params[:keyword_area])
    render :index
  end

  def self.search(keyword_free)
    if keyword_free != ""
      Room.where('text LIKE(?)', "%#{keyword_free}%")
    else
    end
  end

  def self.search(keyword_area)
    if keyword_area != ""
      Room.where('text LIKE(?)', "%#{keyword_area}%")
    else
    end
  end
  
  private

    def room_params
      params.require(:room).permit(:hotel_name, :hotel_detail, :hotel_price, :hotel_address)
    end
end

 

