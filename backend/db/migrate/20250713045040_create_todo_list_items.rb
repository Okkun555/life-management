class CreateTodoListItems < ActiveRecord::Migration[7.2]
  def change
    create_table :todo_list_items do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.references :todo_list, null: false, foreign_key: true, comment: 'TODOリストID'
      t.string :content, null: false, comment: 'TODO内容'
      t.integer :status, null: false, default: 1, comment: 'TODOステータス（1:未完了, 2:完了）'
      t.timestamps
    end
  end
end
