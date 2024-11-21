//
//  workoutScreen.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/17/24.
//

import SwiftUI
 
struct workoutScreen: View {
    var Workout: String
    @State var addingExercise: Bool = false
    @State var addName: String = ""
    @State var addWeight: String = ""
    @State var addReps: String = ""
    @State var addSets: String = ""
    @State var currentSelection = ""
    var body: some View {
        let keys = Array(Master.days[Workout]!.exercises.keys)
        let routine: Schedule.Routine = Master.days[Workout]!
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
                    NavigationLink(destination: exerciseScreen(Workout: Workout,exercise: routine.exercises[currentSelection])){Text("Continue")}
                }.disabled(currentSelection.isEmpty)
            }
            else if(!addingExercise){
                Text("No Exercises Found")
            }
            Text("\n\n")
            Button("Add Exercise?") {
                addingExercise = true
            }
            if(addingExercise){
                TextField("Name",text:$addName)
                TextField("Weight",text:$addWeight)
                TextField("Reps",text:$addReps)
                TextField("Sets",text:$addSets)
                Button("Add") {
                    Master.days[Workout]?.add(exercise: Schedule.Routine.Exercise(Name: addName, Sets: Int(addSets)!, Reps: Int(addReps)!, Weight: Int(addWeight)!))
                    addName = ""; addWeight = ""; addReps = ""; addSets = ""
                    hasExercise = !(Master.days[Workout]!.exercises.isEmpty)
                    addingExercise = false
                }
                Button("Cancel") {
                    addName = ""; addWeight = ""; addReps = ""; addSets = ""
                    hasExercise = !(Master.days[Workout]!.exercises.isEmpty)
                    addingExercise = false
                }
            }
        }
        .padding()
    }
}

#Preview {
    workoutScreen(Workout: "pull")
}
