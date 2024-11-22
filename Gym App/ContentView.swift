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
    func progOverload(exercise: Schedule.Routine.Exercise) {
        if(exercise.sets==5) {
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
    }
    
    class Routine{
        var name: String
        var exercises: [String:Exercise]
        init(Name: String, Exercises: [String:Exercise]) {
            name = Name; exercises = Exercises
        }
        init(){
            name = ""; exercises = [:]
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
                name = Name; sets = Sets; reps = Reps; weight = Weight
            }
            init(){
                name = ""; sets = 0; reps = 0; weight = 0
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

//    var Master = Schedule()
                                /* ~sample data set for testing~ */
    var Master = Schedule(Days:[
        "push":Schedule.Routine(Name:"Push", Exercises:["tricep extension":Schedule.Routine.Exercise(Name:"tricep extension", Sets:5, Reps:11, Weight:65)]),
        "pull":Schedule.Routine(Name: "pull",
        Exercises: ["Lat Pulldown":Schedule.Routine.Exercise(Name: "Lat Pulldown", Sets: 11, Reps: 4, Weight: 65), "Preacher Curl":Schedule.Routine.Exercise(Name: "Preacher Curl", Sets: 3, Reps: 12, Weight: 50), "Rear Delt Fly":Schedule.Routine.Exercise(Name: "Rear Delt Fly", Sets: 5, Reps: 12, Weight: 55)]),
        "legs":Schedule.Routine(Name:"Legs", Exercises:["leg press":Schedule.Routine.Exercise(Name:"leg press", Sets:5, Reps:11, Weight:170)]),
        "chestBack":Schedule.Routine(Name:"ChestBack", Exercises:["pec fly":Schedule.Routine.Exercise(Name:"pec fly", Sets:5, Reps:11, Weight:60)]),
        "shouldersArms":Schedule.Routine(Name:"ShouldersArms", Exercises:["lateral raise":Schedule.Routine.Exercise(Name:"lateral raise", Sets:5, Reps:11, Weight:12)])])

struct ContentView: View {
    @State var currentSelection = ""
    @State var managingRoutine = false
    @State var addingRoutine = false
    @State var deletingRoutine = false
    @State var deleteSelection = ""
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
                    NavigationLink(destination: workoutScreen(workout: currentSelection, schedule: Master)){Text("Select Workout")}
                }.disabled(currentSelection.isEmpty)
            }
            else if(!addingRoutine){
                Text("No Routines Found")
            }
            if(!hasRoutine || managingRoutine){
                if(!addingRoutine && !deletingRoutine){
                    Text("\n")
                    Button("Add a Routine") {
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
                        managingRoutine = false
                    }.disabled(addName.isEmpty)
                    Button("Cancel") {
                        addName = ""
                        hasRoutine = !(Master.days.isEmpty)
                        addingRoutine = false
                        managingRoutine = false
                    }
                }
                
                if(managingRoutine) {
                    if(!addingRoutine && !deletingRoutine) {
                        Button("Delete a Routine") {
                            deletingRoutine = true
                        }
                        Button("Close"){
                            managingRoutine = false
                        }
                    }
                    if(deletingRoutine) {
                        Text("Select a Workout")
                        Picker("Select a Routine", selection: $deleteSelection) {
                            ForEach(routines, id: \.self){ period in
                                Text(period)
                            }
                        }
                        Button("Delete") {
                            Master.days.removeValue(forKey: deleteSelection)
                            deleteSelection = ""
                            hasRoutine = !(Master.days.isEmpty)
                            deletingRoutine = false
                            managingRoutine = false
                        }.disabled(deleteSelection.isEmpty)
                        Button("Cancel") {
                            deleteSelection = ""
                            hasRoutine = !(Master.days.isEmpty)
                            deletingRoutine = false
                            managingRoutine = false
                        }
                    }
                }
            }
            else {
                Button("Manage Routines") {
                    managingRoutine = true
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
