class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :email, null: false
      t.string :password_digest

      t.timestamps
    end
  end
end

# null: false→入力必須とする
# t.string :password_digest→パスワードのハッシュを格納する文字列型のカラム
# ※has_secure_password メソッドによりハッシュ化を実施
