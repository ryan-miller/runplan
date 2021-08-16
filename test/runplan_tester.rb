require_relative '../lib/runplan'

firstWorkout = Workout.new(sport: "RUN", type: "AEROBIC", description: "some running1", minutes: 60)
secondWorkout = Workout.new(sport: "RUN", type: "AEROBIC", description: "some running2", minutes: 120)
thirdWorkout = Workout.new(sport: "RUN", type: "AEROBIC", description: "some running3", minutes: 180)


firstDay = WorkoutDay.new(dayOfWeek: "MONDAY")
secondDay = WorkoutDay.new(dayOfWeek: "TUESDAY")

firstDay.addWorkout(firstWorkout)
secondDay.addWorkout(secondWorkout)
secondDay.addWorkout(thirdWorkout)

workoutWeek = WorkoutWeek.new(weekNumber: 2, type: "BUILD")
workoutWeek.addDay(firstDay)
workoutWeek.addDay(secondDay)

puts "firstWorkout: #{firstWorkout.to_json}"
puts "secondWorkout: #{secondWorkout.to_json}"
puts "firstDay: #{firstDay.to_json}"
# puts "secondDay: #{secondDay.to_json}"
#puts "workoutWeek: #{workoutWeek.to_json}"

puts "total minutes: #{workoutWeek.totalMinutes}"


# bwp = RocheWorkoutPlan.new(planLength: 4, startMinutes: 300)
# bwp.generate
# puts bwp.plan.to_s

# rwp = RocheWorkoutPlan.new(planLength: 4, startMinutes: 300)
# rwp.generate
# puts rwp.plan.to_s