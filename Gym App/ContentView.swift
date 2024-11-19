//
//  ContentView.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/17/24.
//

import SwiftUI
class Schedule{
//    var ID: Int = 0
    var days: [String:Routine]
    init(Days: [String:Routine]){
        days = Days
    }
    init() {
        days = [:]
    }
    func add(Routine:Schedule.Routine) {
        days[Routine.name] = Routine
    }
    func remove(name:String) -> Schedule.Routine {
        let temp = days[name]!
        days.removeValue(forKey: name)
        return temp
    }
    
    func progOverload(Workout: String, exercise: Schedule.Routine.Exercise) {
        if(exercise.sets==5) {
            print("overload")
            if(exercise.reps==12) {
                exercise.setWeight(weight: exercise.weight + 5)
                exercise.setSets(sets: 0)
                exercise.setReps(reps: 10)
            }
            else {
                exercise.setReps(reps: exercise.reps + 1)
                exercise.setSets(sets:0)
            }
        }
        else{
            print("no overload")
        }
        print(exercise.reps)
    }
    
    class Routine{
        var name: String
        var exercises: [String:Exercise]
        init(Name: String, Exercises: [String:Exercise]) {
            name = Name
            exercises = Exercises
        }
        init(){
            name = ""
            exercises = [:]
        }
        func setName(name:String) {
            self.name = name
        }
        //
        func add(exercise:Schedule.Routine.Exercise) {
            exercises[exercise.name] = exercise
        }
        func remove(name:String) -> Schedule.Routine.Exercise {
            let temp = exercises[name]!
            exercises.removeValue(forKey: name)
            return temp
        }
        class Exercise{
            var name: String
            var sets: Int
            var reps: Int
            var weight: Int
            
            init(Name: String, Sets: Int, Reps: Int, Weight: Int) {
                name = Name
                sets = Sets
                reps = Reps
                weight = Weight
            }
            init(){
                name = ""
                sets = 0
                reps = 0
                weight = 0
            }
            
            func setName(name:String) {
                self.name = name
            }
            func setSets(sets:Int) {
                self.sets = sets
            }
            func setReps(reps:Int) {
                self.reps = reps
            }
            func setWeight(weight:Int) {
                self.weight = weight
            }
        }
    }
}


    var Master = Schedule(Days:[
        "none":Schedule.Routine(Name:"",Exercises:["":Schedule.Routine.Exercise(Name:"",Sets:0,Reps:0,Weight:0)]),
        "push":Schedule.Routine(Name:"Push", Exercises:["tricep extension":Schedule.Routine.Exercise(Name:"tricep extension", Sets:5, Reps:11, Weight:65)]),
        "pull":Schedule.Routine(Name:"Pull", Exercises:["preacher curl":Schedule.Routine.Exercise(Name:"preacher curl", Sets:5, Reps:12, Weight:50)]),
        "legs":Schedule.Routine(Name:"Legs", Exercises:["leg press":Schedule.Routine.Exercise(Name:"leg press", Sets:5, Reps:11, Weight:170)]),
        "chestBack":Schedule.Routine(Name:"ChestBack", Exercises:["pec fly":Schedule.Routine.Exercise(Name:"pec fly", Sets:5, Reps:11, Weight:60)]),
        "shouldersArms":Schedule.Routine(Name:"ShouldersArms", Exercises:["lateral raise":Schedule.Routine.Exercise(Name:"lateral raise", Sets:5, Reps:11, Weight:12)])
])
     


enum WorkoutType : String, CaseIterable{
    case none
    case push
    case pull
    case legs
    case chestBack
    case shouldersArms
}

struct ContentView: View {
    @State var Workout: WorkoutType = .none
    var body: some View {
        VStack {
            Text("select workout")
            Picker("select workout", selection: $Workout) {
                ForEach(WorkoutType.allCases, id: \.self) { workout in
                    Text(workout.rawValue)
                }
            }
            NavigationStack{
                NavigationLink(destination: workoutScreen(Workout: Workout)){Text("Start Workout")}
            }
            // Add routine button and text fields
            // github test
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
