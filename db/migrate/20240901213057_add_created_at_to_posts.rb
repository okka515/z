class AddCreatedAtToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :created_at, :datetime
  end
end
