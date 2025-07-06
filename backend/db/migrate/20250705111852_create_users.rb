class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, comment: "アカウント名"
      t.string :email, null: false, comment: "メールアドレス"
      t.string :supabase_uid, null: false, comment: "supabaseのuid"
      t.timestamps
    end

    add_index :users, :supabase_uid, unique: true
    add_index :users, :email, unique: true
  end
end
