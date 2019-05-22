# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
leg_day = Routine.create(name: 'Leg Day')
single_leg_press = Exercise.find_by(name: 'Single-Leg Press')
barbell_full_squat = Exercise.find_by(name: 'Barbell Full Squat')
smith_machine_calf_raise = Exercise.find_by(name: 'Smith Machine Calf Raise')
ExerciseRoutine.create(routine: leg_day, exercise: single_leg_press, sets: 4, reps: 12)
ExerciseRoutine.create(routine: leg_day, exercise: barbell_full_squat, sets: 4, reps: 12)
ExerciseRoutine.create(routine: leg_day, exercise: smith_machine_calf_raise, sets: 4, reps: 20)

arm_day = Routine.create(name: 'Arm Day')
push_ups = Exercise.find_by(name: 'Pushups')
chin_up = Exercise.find_by(name: 'Chin-Up')
barbell_curl = Exercise.find_by(name: 'Barbell Curl')
ExerciseRoutine.create(routine: arm_day, exercise: push_ups, sets: 4, reps: 10)
ExerciseRoutine.create(routine: arm_day, exercise: chin_up, sets: 4, reps: 5)
ExerciseRoutine.create(routine: arm_day, exercise: barbell_curl, sets: 4, reps: 10)
