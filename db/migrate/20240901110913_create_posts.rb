class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :user_id
      t.datetime :create_at
    end
  end
end
