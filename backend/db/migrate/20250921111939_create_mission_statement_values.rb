class CreateMissionStatementValues < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statement_values do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.text :content, null: false, comment: '内容'

      t.timestamps
    end
  end
end
