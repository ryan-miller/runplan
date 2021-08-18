require_relative '../lib/runplan'

firstWorkout = Workout.new(sport: "RUN", type: "AEROBIC", description: "some running1", minutes: 60)
secondWorkout = Workout.new(sport: "RUN", type: "WORKOUT", description: "some running2", minutes: 120)
thirdWorkout = Workout.new(sport: "RUN", type: "AEROBIC", description: "some running3", minutes: 180)

firstDay = WorkoutDay.new(dayOfWeek: "MONDAY")
secondDay = WorkoutDay.new(dayOfWeek: "TUESDAY")

firstDay.addWorkout(firstWorkout)
secondDay.addWorkout(secondWorkout)
secondDay.addWorkout(thirdWorkout)

workoutWeek = WorkoutWeek.new(weekNumber: 2, type: "BUILD")
workoutWeek.addDay(firstDay)
workoutWeek.addDay(secondDay)

params = {:planLength => 12, :startMinutes => 300}

bwp = BryanWorkoutPlan.new(params)
bwp.generate
puts bwp.pretty_print

rwp = RocheWorkoutPlan.new(params)
rwp.generate
puts rwp.pretty_print