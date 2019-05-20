class CreateUserRoutines < ActiveRecord::Migration[5.2]
  def change
    create_table :user_routines do |t|
      t.date :date
      t.references :routine, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
