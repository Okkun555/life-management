class CreateTodoReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :todo_reviews do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.references :todo_list, null: false, foreign_key: true, comment: 'TODOリストID'
      t.text :review, comment: '振り返りコメント'
      t.timestamps
    end
  end
end
