class CreateSleeps < ActiveRecord::Migration[7.2]
  def change
    create_table :sleeps, id: :uuid do |t|
      t.references :user, null: false, type: :uuid, foreign_key: true
      t.datetime :start_time, null: false, precision: 6
      t.datetime :end_time, precision: 6
      t.bigint :duration_seconds
      t.timestamps
    end

    add_index :sleeps, :start_time
    add_index :sleeps, :end_time
    add_index :sleeps, [ :user_id, :start_time ]

    # Add partial unique index: one open sleep per user
    add_index :sleeps, :user_id, unique: true, where: "end_time IS NULL", name: "index_sleeps_on_user_id_open_sleep"
  end
end
