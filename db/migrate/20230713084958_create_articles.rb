class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps null: false
    end
  end
end

