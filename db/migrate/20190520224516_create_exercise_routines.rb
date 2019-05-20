class CreateExerciseRoutines < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_routines do |t|
      t.integer :reps
      t.integer :sets
      t.integer :weight
      t.integer :duration
      t.references :routine, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
