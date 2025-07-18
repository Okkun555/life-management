class CreateTodoLists < ActiveRecord::Migration[7.2]
  def change
    create_table :todo_lists do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.string :title, null: false, comment: 'リストタイトル（通常は日付が入る）'
      t.boolean :is_current, null: false, default: false, comment: '当日有効なリストかどうか'
      t.timestamps
    end

    add_index :todo_lists, [:user_id, :title], unique: true
  end
end
