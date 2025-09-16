class CreateUsersFollows < ActiveRecord::Migration[7.2]
  def change
    create_table :user_follows, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :followed_id, null: false
      t.timestamps
    end

    add_index :user_follows, [ :user_id, :followed_id ], unique: true, name: 'idx_user_follows_on_user_id_and_followed_id'
    add_index :user_follows, :followed_id, name: 'idx_user_follows_on_followed_id'
    add_index :user_follows, :user_id, name: 'idx_user_follows_on_user_id'
  end
end
