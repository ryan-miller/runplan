class Workout
    attr_accessor :sport, :type, :description, :minutes

    def initialize(sport: "", type: "", description: "", minutes: 0)
        @sport = sport
        @type = type
        @description = description
        @minutes = minutes
    end

    def inspect
        "WO: #{@sport}, #{@type}, #{@minutes})"
    end

end

class WorkoutDay
    attr_accessor :dayOfWeek, :workouts

    def initialize(dayOfWeek: "UNDEFINED", workouts: [])
        @dayOfWeek = dayOfWeek
        @workouts = workouts
    end

    def addWorkout(workout)
        @workouts.push(workout)
    end

    def totalMinutes
        sum = 0
        @workouts.each { |workout| sum += workout.minutes }
        sum
    end

    def inspect
        "WOD: #{@dayOfWeek}, #{totalMinutes}, \n#{@workouts})"
    end

end

class WorkoutWeek
    attr_accessor :weekNumber, :type, :days
  
    def initialize(weekNumber: 0, type: "", days: [])
        @weekNumber = weekNumber
        @type = type
        @days = days
    end

    def addDay(workoutDay)
        @days.push(workoutDay)
    end

    def addWorkoutToDay(day, workout)
        @days[day].addWorkout(workout)
    end

    def totalMinutes
        sum = 0
        @days.each { |day| sum += day.totalMinutes}
        sum
    end

    def inspect
        "\nWOW: #{@weekNumber}, #{@type}, #{totalMinutes})\n,days: \n#{@days}"
    end
end

class WorkoutPlan
    attr_accessor :planLength, :startMinutes, :blockSize, :buildFactor, :recoveryFactor, :maxTime, :startDate
    attr_reader :plan

    def initialize(planLength: 12, blockSize: 4, buildFactor: 1.2, recoveryFactor: 0.85, 
        minMinutes: 240, maxMinutes: 600, startDate: "", startMinutes: 240)
        @plan = []
        @planLength = planLength
        @startMinutes = startMinutes
        @buildFactor = buildFactor
        @recoveryFactor = recoveryFactor
        @minMinutes = minMinutes
        @maxMinutes = maxMinutes
        @blockSize = blockSize
    end
    
    def generate

        @minutes = @startMinutes
        (1..@planLength).each { |i|
        
            ww = WorkoutWeek.new(weekNumber: i)
            monday = WorkoutDay.new(dayOfWeek: "MONDAY")
            monday.addWorkout(Workout.new(type: "REST", description: "rest day", minutes: 0))
            ww.addDay(monday)
            tuesday = WorkoutDay.new(dayOfWeek: "TUESDAY")
            tuesday.addWorkout(Workout.new(type: "RUN", description: "aerobic day", minutes: (@minutes * 0.1).round(0)))
            ww.addDay(tuesday)
            wednesday = WorkoutDay.new(dayOfWeek: "WEDNESDAY")
            wednesday.addWorkout(Workout.new(type: "RUN", description: "workout day", minutes: (@minutes * 0.2).round(0)))
            ww.addDay(wednesday)
            thursday = WorkoutDay.new(dayOfWeek: "THURSDAY")
            thursday.addWorkout(Workout.new(type: "RUN", description: "workout day", minutes: (@minutes * 0.1).round(0)))
            ww.addDay(thursday)
            friday = WorkoutDay.new(dayOfWeek: "FRIDAY")
            friday.addWorkout(Workout.new(type: "RUN", description: "workout day", minutes: (@minutes * 0.2).round(0)))
            ww.addDay(friday)
            saturday = WorkoutDay.new(dayOfWeek: "SATURDAY")
            saturday.addWorkout(Workout.new(type: "RUN", description: "workout day", minutes: (@minutes * 0.1).round(0)))
            ww.addDay(saturday)
            sunday = WorkoutDay.new(dayOfWeek: "SUNDAY")
            sunday.addWorkout(Workout.new(type: "RUN", description: "workout day", minutes: (@minutes * 0.3).round(0)))
            ww.addDay(sunday)
            @plan.push(ww)

            calculateFactor(i)
        }
    end

    def calculateFactor(weekNum) 
        puts @blockSize
        if weekNum > 1
            if weekNum % @blockSize == 0
                @minutes = @minutes * @recoveryFactor
                if @minutes < @minMinutes
                    @minutes = @minMinutes
                end
            else
                @minutes = @minutes * @buildFactor
                if @minutes > @maxMinutes
                    @minutes = @maxMinutes
                end
            end
        end

    end

    def weekTotal(weekNum) 
        t = 0.0
        @plan.at(weekNum).each { |a| t+=a }
        return t.round(0)
    end

    def describe
        puts @plan.to_s
    end

    def inspect
        "Workout Plan: \n
        Plan Length: #{@planLength}"
    
    end


end