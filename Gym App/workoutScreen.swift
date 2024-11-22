//
//  workoutScreen.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/17/24.
//
import SwiftUI
var completedArr : [String:Bool] = [:]
var numCompleted: Int = 0
struct workoutScreen: View {
    var workout: String
    var schedule: Schedule
    @State var addingExercise: Bool = false
    @State var deletingExercise: Bool = false
    @State var managingExercise: Bool = false
    @State var lookingExercise: Bool = false
    @State var addName: String = ""
    @State var addWeight: String = ""
    @State var addReps: String = ""
    @State var addSets: String = ""
    @State var currentSelection = ""
    @State var deleteSelection = ""
    var body: some View {
        let keys = Array(schedule.days[workout]!.exercises.keys)
        let routine: Schedule.Routine = schedule.days[workout]!
        @State var hasExercise: Bool = !(keys.isEmpty)
        @State var completedState = completedArr
        VStack {
            if(hasExercise){
                NavigationStack {
                    NavigationLink(destination: smartRoutine(workout: workout, routine: routine, schedule: schedule)){Text("Smart Routine")}
                }
                Text("Select an Exercise")
                Picker("Select an Exercise", selection: $currentSelection) {
                    ForEach(keys, id: \.self){ period in
                        if(!(completedState[period] ?? false)) {
                            Text(period)
                        }
                    }
                }
                NavigationStack{
                    NavigationLink(destination: exerciseScreen(workout: workout, schedule: schedule,exercise: routine.exercises[currentSelection])){Text("Continue")}
                }.disabled(currentSelection.isEmpty).simultaneousGesture(TapGesture().onEnded(){
                    currentSelection = ""
                })
            }
            else if(!addingExercise && !deletingExercise){
                Text("No Exercises Found")
            }
            if(managingExercise || !hasExercise) {
                if(!addingExercise && !deletingExercise) {
                    Text("\n\n")
                    Button("Add an Exercise") {
                        addingExercise = true
                    }
                }
                if(addingExercise){
                    TextField("Name",text:$addName)
                    TextField("Weight",text:$addWeight)
                    TextField("Reps",text:$addReps)
                    TextField("Sets",text:$addSets)
                    Button("Add") {
                        schedule.days[workout]?.add(exercise: Schedule.Routine.Exercise(Name: addName, Sets: Int(addSets)!, Reps: Int(addReps)!, Weight: Int(addWeight)!))
                        addName = ""; addWeight = ""; addReps = ""; addSets = ""
                        hasExercise = !(schedule.days[workout]!.exercises.isEmpty)
                        addingExercise = false
                        managingExercise = false
                    }
                    Button("Cancel") {
                        addName = ""; addWeight = ""; addReps = ""; addSets = ""
                        hasExercise = !(schedule.days[workout]!.exercises.isEmpty)
                        addingExercise = false
                        managingExercise = false
                    }
                }
                if(managingExercise){
                    if(!addingExercise && !deletingExercise) {
                        Button("Delete an Exercise") {
                            deletingExercise = true
                        }
                        Button("Close") {
                            managingExercise = false
                        }
                    }
                    if(deletingExercise) {
                        Text("Select an Exercise")
                        Picker("Select an Exercise", selection: $deleteSelection) {
                            ForEach(keys, id: \.self){ period in
                                Text(period)
                            }
                        }
                        Button("Delete") {
                            schedule.days[workout]!.exercises.removeValue(forKey: deleteSelection)
                            deleteSelection = ""
                            hasExercise = !(schedule.days[workout]!.exercises.isEmpty)
                            deletingExercise = false
                            managingExercise = false
                        }.disabled(deleteSelection.isEmpty)
                        Button("Cancel") {
                            deleteSelection = ""
                            hasExercise = !(schedule.days[workout]!.exercises.isEmpty)
                            deletingExercise = false
                            managingExercise = false
                        }
                    }
                }
            }
            else {
                Button("Manage Exercises") {
                    managingExercise = true
                }
            }
        }
        .padding()
    }
}

#Preview {
    let test: Schedule = Schedule(Days: ["Pull":Schedule.Routine(Name: "Pull",
    Exercises: ["Lat Pulldown":Schedule.Routine.Exercise(Name: "Lat Pulldown", Sets: 11, Reps: 4, Weight: 65), "Preacher Curl":Schedule.Routine.Exercise(Name: "Preacher Curl", Sets: 3, Reps: 12, Weight: 50), "Rear Delt Fly":Schedule.Routine.Exercise(Name: "Rear Delt Fly", Sets: 5, Reps: 12, Weight: 55)])])
    workoutScreen(workout: "Pull", schedule: test)
}
