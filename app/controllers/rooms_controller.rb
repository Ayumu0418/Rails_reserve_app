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
  # new アクションにより、新しいユーザーオブジェクトを作成して、@user インスタンス変数に代入する。これにより、新しいユーザーアカウントの入力フォームを表示する準備が整う。

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(room_params)

    if params[:room][:hotel_image].present?
      @room.hotel_image.attach(params[:room][:hotel_image])
    end
    # ↑上記コード追加でindex.htmlに画像が反映された

    if @room.save
        redirect_to root_path, notice: "新しい施設を作成しました。"
      # create アクションは、ユーザーアカウントの作成を試みる。user_params メソッドを使用して、フォームから送信されたユーザーデータを取得し、User.new を使用して新しいユーザーオブジェクトを作成し、正常に保存された場合（バリデーションに通過した場合）、ユーザーはトップページにリダイレクトされ、notice メッセージが表示される。
    else
      render :new_room
    end
  end
      # ユーザーオブジェクトの保存に失敗した場合（バリデーションエラーがある場合）、入力エラーメッセージを持つ新しいユーザーオブジェクトを使って new テンプレートを再表示する。
    
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
  # この user_params メソッドは、Strong Parameters と呼ばれる Rails のセキュリティ機能を使用している。Strong Parameters は、フォームから受け取ったパラメータをホワイトリストに登録し、許可されていないパラメータがコントローラーに渡されるのを防ぐことができる。

  # params.require(:user):
  # params ハッシュから :user キーに関連付けられたハッシュを取り出す。これにより、フォームからのユーザー関連の情報だけが取得される。

  # .permit(:user_name, :email, :password, :password_confirmation):
  # ホワイトリストに登録する許可されたパラメータを指定する。
  # ここでは、:user_name、:email、:password、:password_confirmation の4つのパラメータが許可されている。
  # これにより、フォームから送信された他のパラメータが無視され、安全にデータが取り扱われる。
  # Strong Parameters を使用することで、不正なパラメータがコントローラーに渡されることを防ぎ、セキュリティを向上させることができる。

 

