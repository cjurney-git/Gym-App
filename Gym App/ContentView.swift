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

     var Master = Schedule()
//    var Master = Schedule(Days:[
//        "push":Schedule.Routine(Name:"Push", Exercises:["tricep extension":Schedule.Routine.Exercise(Name:"tricep extension", Sets:5, Reps:11, Weight:65)]),
//        "pull":Schedule.Routine(Name:"Pull", Exercises:["preacher curl":Schedule.Routine.Exercise(Name:"preacher curl", Sets:5, Reps:12, Weight:50)]),
//        "legs":Schedule.Routine(Name:"Legs", Exercises:["leg press":Schedule.Routine.Exercise(Name:"leg press", Sets:5, Reps:11, Weight:170)]),
//        "chestBack":Schedule.Routine(Name:"ChestBack", Exercises:["pec fly":Schedule.Routine.Exercise(Name:"pec fly", Sets:5, Reps:11, Weight:60)]),
//        "shouldersArms":Schedule.Routine(Name:"ShouldersArms", Exercises:["lateral raise":Schedule.Routine.Exercise(Name:"lateral raise", Sets:5, Reps:11, Weight:12)])])

struct ContentView: View {
    @State var currentSelection = ""
    @State var addingRoutine = false
    @State var addName = ""
    @State var hasRoutine : Bool = !(Master.days.isEmpty)
    var body: some View {
        let routines = Array(Master.days.keys)
        VStack {
            if(hasRoutine) {
                Text("Select a Workout")
                Picker("Select a Routine", selection: $currentSelection) {
                    ForEach(routines, id: \.self){ period in
                        Text(period)
                    }
                }
                NavigationStack{
                    NavigationLink(destination: workoutScreen(Workout: currentSelection)){Text("Select Workout")}
                }.disabled(currentSelection.isEmpty)
            }
            else if(!addingRoutine){
                Text("No Routines Found")
            }
            
            if(!addingRoutine){
                Text("\n")
                Button("Add Routine?") {
                    addingRoutine = true
                }
            }
            if(addingRoutine){
                TextField("Name",text:$addName)
                Button("Add") {
                    Master.days[addName] = Schedule.Routine(Name:addName, Exercises:[:])
                    addName = ""
                    hasRoutine = !(Master.days.isEmpty)
                    addingRoutine = false
                }.disabled(addName.isEmpty)
                Button("Cancel") {
                    addName = ""
                    hasRoutine = !(Master.days.isEmpty)
                    addingRoutine = false
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
