class RoutineSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :exercises do |object|
    object.exercises.map do |ex|
      ers = object.exercise_routines
      er = ers.detect {|ex_r| ex_r.exercise_id == ex.id}
      {
        id: ex.id,
        name: ex.name,
        category: ex.category,
        equipment_required: ex.equipment_required,
        muscle: ex.muscle,
        reps: er.reps,
        sets: er.sets,
        duration: er.duration,
        weight: er.weight
      }
    end
  end
end
