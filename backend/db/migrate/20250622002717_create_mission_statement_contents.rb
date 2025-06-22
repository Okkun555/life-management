class CreateMissionStatementContents < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statement_contents do |t|
      t.references :mission_statement, null: false, foreign_key: true
      t.text :content, null: false, comment: "ミッションステートメント内容"
      t.timestamps
    end
  end
end
