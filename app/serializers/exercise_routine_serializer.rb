class ExerciseRoutineSerializer
  include FastJsonapi::ObjectSerializer
  attributes :exercise_id, :routine_id, :reps, :sets, :duration, :weight
end
