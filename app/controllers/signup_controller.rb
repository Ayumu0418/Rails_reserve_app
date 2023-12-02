class SignupController < ApplicationController
  def new
    @user = User.new
  end
  # new アクションにより、新しいユーザーオブジェクトを作成して、@user インスタンス変数に代入する。これにより、新しいユーザーアカウントの入力フォームを表示する準備が整う。

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to root_path, notice: "アカウントを作成しました。"
      # create アクションは、ユーザーアカウントの作成を試みる。user_params メソッドを使用して、フォームから送信されたユーザーデータを取得し、User.new を使用して新しいユーザーオブジェクトを作成し、正常に保存された場合（バリデーションに通過した場合）、ユーザーはトップページにリダイレクトされ、notice メッセージが表示される。
    else
        render :new
    end
      # ユーザーオブジェクトの保存に失敗した場合（バリデーションエラーがある場合）、入力エラーメッセージを持つ新しいユーザーオブジェクトを使って new テンプレートを再表示する。
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
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





