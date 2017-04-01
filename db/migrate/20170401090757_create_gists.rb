class CreateGists < ActiveRecord::Migration[5.0]
  def change
    create_table :gists do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :lang_mode
      t.integer :user_id, index: true, null: false
      t.timestamps
    end
  end
end
