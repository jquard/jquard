class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body
      t.integer :status, null: false, default: 0
      t.boolean :featured, null: false, default: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
