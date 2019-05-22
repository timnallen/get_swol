class RoutineSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :exercises do |object|
    object.exercises.map do |ex|
      er = ExerciseRoutine.find_by(routine_id: object.id, exercise_id: ex.id)
      {
        id: ex.id,
        name: ex.name,
        category: ex.category,
        muscle: ex.muscle,
        reps: er.reps,
        sets: er.sets,
        duration: er.duration,
        weight: er.weight
      }
    end
  end
end
