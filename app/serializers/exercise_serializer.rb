class ExerciseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :category, :equipment_required
end
