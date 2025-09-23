class CreateMissionStatements < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statements do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.string :content, null: false, limit: 100, comment: '内容'
      t.integer :version, null: false, default: 1, comment: 'バージョン'

      t.timestamps
    end
  end
end
