class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, comment: 'ユーザーID'
      t.date :birthday, null: false, comment: '生年月日'
      t.integer :sex, null: false, default: 0, comment: '生物学的性別(0:秘密, 1:男性, 2:女性)'
      t.boolean :is_public, null: false, default: false, comment: '公開設定(0:非公開, 1:公開)'
      t.timestamps
    end
  end
end
