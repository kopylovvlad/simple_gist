class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id, index: true, null: false
      t.integer :gist_id, index: true, null: false
      t.timestamps
    end
  end
end
