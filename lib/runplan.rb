require 'json'

class Workout
    attr_accessor :sport, :type, :description, :minutes

    def initialize(params = {})
        @sport = params.fetch(:sport, "")
        @type = params.fetch(:type, "")
        @description = params.fetch(:description, "")
        @minutes = params.fetch(:minutes, 0)
    end
    
    def to_json
        {'sport' => @sport, 'type' => @type, 'description' => @description, 'minutes' => @minutes}.to_json
    end

    def self.from_json string
        data = JSON.load string
        self.new data['sport'], data['type'], data['description'], data['minutes']
    end

end

class WorkoutDay
    attr_accessor :dayOfWeek, :workouts

    def initialize(params = {})
        @dayOfWeek = params.fetch(:dayOfWeek, "UNDEFINED")
        @workouts = params.fetch(:workouts, [])
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
        "\n|#{@dayOfWeek}:#{totalMinutes}|" +
        "#{@workouts}\n"
    end

end

class WorkoutWeek
    attr_accessor :weekNumber, :type, :days
  
    def initialize(params = {})
        @weekNumber = params.fetch(:weekNumber, 0)
        @type = params.fetch(:type, "")
        @days = params.fetch(:days, [])
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
        "#{@weekNumber}:#{@type}:#{totalMinutes}\n------------------------------\n"+
        "#{@days.inspect}"+
        "\n------------------------------\n"
    end
end

class WorkoutPlan
    attr_accessor :planLength, :startMinutes, :blockSize, :buildFactor, :recoveryFactor, :maxTime, :startDate
    attr_reader :plan

    def initialize(params = {})
        @plan = []
        @planLength = params.fetch(:planLength, 12)
        @startMinutes = params.fetch(:startMinutes, 240)
        @buildFactor = params.fetch(:buildFactor, 1.2)
        @recoveryFactor = params.fetch(:recoveryFactor, 0.85)
        @minMinutes = params.fetch(:minMinutes, 240)
        @maxMinutes = params.fetch(:maxMinutes, 600)
        @blockSize = params.fetch(:blockSize, 4)
    end
    
    def generate

    end

    def calculateFactor(weekNum) 
        #if weekNum > 1
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
        #end

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
        "\nWORKOUT PLAN\n"
        describe
    
    end

end

class BryanWorkoutPlan < WorkoutPlan

    def initialize(params = {})
        super(params)
    end

    def generate

        @minutes = @startMinutes
        (1..@planLength).each { |i|
        
            ww = WorkoutWeek.new(weekNumber: i)
            monday = WorkoutDay.new(dayOfWeek: "MON")
            monday.addWorkout(Workout.new(type: "REST", description: "d", minutes: 0))
            ww.addDay(monday)
            tuesday = WorkoutDay.new(dayOfWeek: "TUE")
            tuesday.addWorkout(Workout.new(type: "STRIDES", description: "d", minutes: (@minutes * 0.1).round(0)))
            ww.addDay(tuesday)
            wednesday = WorkoutDay.new(dayOfWeek: "WED")
            wednesday.addWorkout(Workout.new(type: "HILLS", description: "d", minutes: (@minutes * 0.2).round(0)))
            ww.addDay(wednesday)
            thursday = WorkoutDay.new(dayOfWeek: "THU")
            thursday.addWorkout(Workout.new(type: "EASY", description: "d", minutes: (@minutes * 0.1).round(0)))
            ww.addDay(thursday)
            friday = WorkoutDay.new(dayOfWeek: "FRI")
            friday.addWorkout(Workout.new(type: "STRIDES", description: "d", minutes: (@minutes * 0.2).round(0)))
            ww.addDay(friday)
            saturday = WorkoutDay.new(dayOfWeek: "SAT")
            saturday.addWorkout(Workout.new(type: "EASY", description: "d", minutes: (@minutes * 0.1).round(0)))
            ww.addDay(saturday)
            sunday = WorkoutDay.new(dayOfWeek: "SUN")
            sunday.addWorkout(Workout.new(type: "LONG", description: "d", minutes: (@minutes * 0.3).round(0)))
            ww.addDay(sunday)
            @plan.push(ww)

            calculateFactor(i)
        }
    end

end

class RocheWorkoutPlan < WorkoutPlan

    def initialize(params = {})
        super(params)
    end

    def generate

        @minutes = @startMinutes
        (1..@planLength).each { |i|
        
            ww = WorkoutWeek.new(weekNumber: i)
            monday = WorkoutDay.new(dayOfWeek: "MON")
            monday.addWorkout(Workout.new(sport: "REST", type: "REST", description: "rest day", minutes: 0))
            ww.addDay(monday)
            tuesday = WorkoutDay.new(dayOfWeek: "TUE")
            tuesday.addWorkout(Workout.new(sport: "RUN", type: "STRIDES", description: "8x20s strides on 2:00", minutes: (@minutes * 0.15).round(0)))
            ww.addDay(tuesday)
            wednesday = WorkoutDay.new(dayOfWeek: "WED")
            wednesday.addWorkout(Workout.new(sport: "RUN", type: "HILLS", description: "Hill repeats 8 x 30s", minutes: (@minutes * 0.2).round(0)))
            ww.addDay(wednesday)
            thursday = WorkoutDay.new(dayOfWeek: "THU")
            thursday.addWorkout(Workout.new(sport: "RUN", type: "EASY", description: "easy zone 1", minutes: (@minutes * 0.15).round(0)))
            ww.addDay(thursday)
            friday = WorkoutDay.new(dayOfWeek: "FRI")
            friday.addWorkout(Workout.new(sport: "REST", type: "REST", description: "rest day", minutes: (@minutes * 0).round(0)))
            ww.addDay(friday)
            saturday = WorkoutDay.new(dayOfWeek: "SAT")
            saturday.addWorkout(Workout.new(sport: "RUN", type: "LONG", description: "long and easy", minutes: (@minutes * 0.35).round(0)))
            ww.addDay(saturday)
            sunday = WorkoutDay.new(dayOfWeek: "SUN")
            sunday.addWorkout(Workout.new(sport: "RUN", type: "STRIDES", description: "5 x 1:00 on 2:00", minutes: (@minutes * 0.15).round(0)))
            ww.addDay(sunday)
            @plan.push(ww)

            calculateFactor(i)
        }
    end

    
end