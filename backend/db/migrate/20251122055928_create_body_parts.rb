class CreateBodyParts < ActiveRecord::Migration[7.2]
  def change
    create_table :body_parts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, comment: '部位名'
      t.string :ancestry, comment: '階層'

      t.timestamps
    end
    add_index :body_parts, :ancestry
  end
end
