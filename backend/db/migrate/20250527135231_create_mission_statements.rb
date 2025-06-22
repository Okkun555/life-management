class CreateMissionStatements < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statements do |t|
      t.string :name, null: false, comment: "ミッションステートメント名"
      t.timestamps
    end
  end
end
