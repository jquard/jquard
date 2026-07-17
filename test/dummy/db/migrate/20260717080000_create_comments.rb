class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.string :author_name, null: false
      t.text :body
      t.boolean :approved, null: false, default: false
      t.datetime :posted_at

      t.timestamps
    end
  end
end
