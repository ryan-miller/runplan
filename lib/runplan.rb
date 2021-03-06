require 'json'

class Integer
    def pretty_duration
        parse_string = 
            if self < 3600
                '%M:%S'
            else
                '%H:%M:%S'
            end

        Time.at(self).utc.strftime(parse_string)
    end
end

class Serializeable
    def to_json(options={})
        hash = {}

        self.instance_variables.each do |var|
            var_string = var.to_s.sub "@",""
            hash[var_string] = self.instance_variable_get var
        end
        
        hash.to_json
    end

    def from_json! string
        JSON.load(string).each do |var, val|
            self.instance_variable_set var, val
        end
    end
end

class Workout < Serializeable
    attr_accessor :sport, :type, :description, :minutes

    def initialize(params = {})
        @sport = params.fetch(:sport, "")
        @type = params.fetch(:type, "")
        @description = params.fetch(:description, "")
        @minutes = params.fetch(:minutes, 0)
    end

end

class WorkoutDay < Serializeable
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
        workouts.each { |workout| sum += workout.minutes }
        sum
    end

end

class WorkoutWeek < Serializeable
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

end

class WorkoutPlan < Serializeable
    attr_accessor :planLength, :startMinutes, :blockSize, :buildFactor, :recoveryFactor, :maxTime, :startDate
    attr_reader :plan, :planName

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

    def pretty_print
        output = "W\tD\tM\tT\tW\tT\tF\tS\tS\tT\n"
        plan.each do |week|
            output += "#{week.weekNumber}\t"
            output += "#{week.type}\t"
            (0..6).each do |dayNum|
                output += "#{week.days[dayNum].workouts[0].minutes.pretty_duration}\t"
            end
            output += "#{week.totalMinutes.pretty_duration}"
            output += "\n"
        end
        output += "\n"
        output += "R = rest\n"
        output += "W = workout\n"
        output += "E = easy\n"
        output += "S = strides\n"
        output += "L = long\n"
        output += "F = fast finish\n"
        output += "T = tempo\n"
       output 
    end

end

class BarryWorkoutPlan < WorkoutPlan

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
        planName = "ROCHE"
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