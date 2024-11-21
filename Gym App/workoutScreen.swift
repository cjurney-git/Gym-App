//
//  workoutScreen.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/17/24.
//

import SwiftUI
struct workoutScreen: View {
    var Workout: String
    var schedule: Schedule
    @State var addingExercise: Bool = false
    @State var deletingExercise: Bool = false
    @State var managingExercise: Bool = false
    @State var addName: String = ""
    @State var addWeight: String = ""
    @State var addReps: String = ""
    @State var addSets: String = ""
    @State var currentSelection = ""
    @State var deleteSelection = ""
    var body: some View {
        let keys = Array(schedule.days[Workout]!.exercises.keys)
        let routine: Schedule.Routine = schedule.days[Workout]!
        @State var hasExercise: Bool = !(keys.isEmpty)
        VStack {
            if(hasExercise){
                Text("Select an Exercise")
                Picker("Select an Exercise", selection: $currentSelection) {
                    ForEach(keys, id: \.self){ period in
                        Text(period)
                    }
                }
                NavigationStack{
                    NavigationLink(destination: exerciseScreen(Workout: Workout, schedule: schedule,exercise: routine.exercises[currentSelection])){Text("Continue")}
                }.disabled(currentSelection.isEmpty)
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
                        schedule.days[Workout]?.add(exercise: Schedule.Routine.Exercise(Name: addName, Sets: Int(addSets)!, Reps: Int(addReps)!, Weight: Int(addWeight)!))
                        addName = ""; addWeight = ""; addReps = ""; addSets = ""
                        hasExercise = !(schedule.days[Workout]!.exercises.isEmpty)
                        addingExercise = false
                        managingExercise = false
                    }
                    Button("Cancel") {
                        addName = ""; addWeight = ""; addReps = ""; addSets = ""
                        hasExercise = !(schedule.days[Workout]!.exercises.isEmpty)
                        addingExercise = false
                        managingExercise = false
                    }
                }
                if(managingExercise){
                    if(!addingExercise && !deletingExercise) {
                        Text("\n")
                        Button("Delete an Exercise") {
                            deletingExercise = true
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
                            schedule.days[Workout]!.exercises.removeValue(forKey: deleteSelection)
                            deleteSelection = ""
                            hasExercise = !(schedule.days[Workout]!.exercises.isEmpty)
                            deletingExercise = false
                            managingExercise = false
                        }.disabled(deleteSelection.isEmpty)
                        Button("Cancel") {
                            deleteSelection = ""
                            hasExercise = !(schedule.days[Workout]!.exercises.isEmpty)
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
    let test: Schedule = Schedule(Days: ["Pull":Schedule.Routine(Name: "Pull", Exercises: ["Lat Pulldown":Schedule.Routine.Exercise(Name: "Lat Pulldown", Sets: 11, Reps: 4, Weight: 65)])])
    workoutScreen(Workout: "Pull", schedule: test)
}
