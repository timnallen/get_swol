class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :category
      t.string :equipment_required

      t.timestamps
    end
  end
end
