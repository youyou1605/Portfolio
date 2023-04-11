class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :customer, foreign_key: true
      t.references :follower, foreign_key: { to_table: :customers }
      t.index [:customer_id, :follower_id], unique: true
      t.integer :followed_id
      t.timestamps

    end
  end
end
