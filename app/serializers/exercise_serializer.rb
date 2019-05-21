class ExerciseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :category, :equipment_required, :muscle
end
