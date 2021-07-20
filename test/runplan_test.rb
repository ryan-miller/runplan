gem 'minitest', '~>5'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/runplan'

class WorkoutTest < Minitest::Test
    def test_basic_workout
        expected = ""
        assert_equal expected, Workout.new.type
    end
    def test_workout_with_description
        expected = "Some running."
        assert_equal expected, Workout.new(description: "Some running.").description
    end

end

class WorkoutDayTest < Minitest::Test
    def test_basic_workout_day
        expected = "UNDEFINED"
        assert_equal expected, WorkoutDay.new().dayOfWeek
    end
    def test_runday_with_time
        first = Workout.new(sport: "RUN", type: "AEROBIC", description: "some running", minutes: 60)
        second = Workout.new(sport: "BIKE", type: "AEROBIC", description: "some biking", minutes: 75)

        expected = 135
        d = WorkoutDay.new(dayOfWeek: "MONDAY")
        d.addWorkout(first)
        d.addWorkout(second)
        assert_equal expected, d.totalMinutes
    end
    def test_setting_workout_day_day_of_week
        expected = "FRIDAY"
        assert_equal expected, WorkoutDay.new(dayOfWeek: "FRIDAY").dayOfWeek
    end
end

class WorkoutWeekTest < Minitest::Test
    def test_basic_workout_week
        expected = 0
        assert_equal expected, WorkoutWeek.new().weekNumber
    end
    def test_workout_week_total_time
        firstWorkout = Workout.new(minutes: 12)
        secondWorkout = Workout.new(minutes: 50)
        firstDay = WorkoutDay.new(dayOfWeek: "MONDAY")
        firstDay.addWorkout(firstWorkout)
        firstDay.addWorkout(secondWorkout)

        thirdWorkout = Workout.new(minutes: 120)
        secondDay = WorkoutDay.new(dayOfWeek: "TUESDAY")
        secondDay.addWorkout(thirdWorkout)

        ww = WorkoutWeek.new(weekNumber: 6, type: "BUILD")
        ww.addDay(firstDay)
        ww.addDay(secondDay)

        expected = 182
        assert_equal expected, ww.totalMinutes
    end

end

class BryanPlanTest < Minitest::Test
    def test_basic_bryan_workout_plan
        wp = BryanWorkoutPlan.new
        wp.generate
        expected = 12
        assert_equal expected, wp.plan.length
    end
    def test_3_week_bryan_workout_plan
        wp = BryanWorkoutPlan.new(planLength: 3)
        wp.generate
        expected = 3
        assert_equal expected, wp.plan.length
    end
end

class RochePlanTest < Minitest::Test
    def test_basic_roche_workout_plan
        wp = BryanWorkoutPlan.new
        wp.generate
        expected = 12
        assert_equal expected, wp.plan.length
    end
    def test_3_week_roche_workout_plan
        wp = BryanWorkoutPlan.new(planLength: 3)
        wp.generate
        expected = 3
        assert_equal expected, wp.plan.length
    end
end