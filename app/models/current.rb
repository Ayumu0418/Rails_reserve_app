class Current < ApplicationRecord
  cattr_accessor :user
  # cattr_accessorはクラス変数（クラスのインスタンス間で共有される変数）を作成し、:user というクラス変数を作成する。この変数は Current クラス内で共有される。
  # ※cattr_accessor: 値をすべてのクラスで共有したい場合に使う

  def self.set(user)
    self.user = user
  end
  # クラスメソッド set は、引数として受け取ったユーザーオブジェクトを :user クラス変数にセットする役割を持ち、現在のユーザーを設定するためにこのメソッドを呼び出す。

  def self.get
    self.user
  end
  # クラスメソッド get は、現在のユーザーオブジェクトを取得するためのメソッドで、Current.user を返すことで、現在のユーザーを取得できる。
end