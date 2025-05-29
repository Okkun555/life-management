class CreateMissionStatements < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statements do |t|
      t.text :content, null: false, comment: "ミッションステートメント"
      t.timestamps
    end
  end
end
