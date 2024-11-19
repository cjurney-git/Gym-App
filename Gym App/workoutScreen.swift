//
//  workoutScreen.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/17/24.
//

import SwiftUI
 
struct workoutScreen: View {
    var Workout: WorkoutType
    @State var addingExercise: Bool = false
    @State var addName: String = ""
    @State var addWeight: String = ""
    @State var addReps: String = ""
    @State var addSets: String = ""
    @State var currentSelection = ""
    @State var currentIndex = 0 {
        didSet {
            let keys = Master.days[Workout.rawValue]!.exercises.keys
            currentSelection = Master.days[Workout.rawValue]!.exercises[keys.first!]!.name
        }
    }
    var body: some View {
        let keys = Array(Master.days[Workout.rawValue]!.exercises.keys)
        let routine: Schedule.Routine = Master.days[Workout.rawValue]!
        VStack {
            Text("Select Exercise")
            Picker("Select an Exercise", selection: $currentSelection) {
                ForEach(keys, id: \.self){ period in
                    Text(period)
                }
            }
            NavigationStack{
                NavigationLink(destination: exerciseScreen(Workout: Workout,exercise: routine.exercises[currentSelection])){Text("Continue")}
            }
            Button("\n\nAdd Exercise?") {
                addingExercise = true
            }
            
            if(addingExercise){
                TextField("Name",text:$addName)
                TextField("Weight",text:$addWeight)
                TextField("Reps",text:$addReps)
                TextField("Sets",text:$addSets)
                Button("Add") {
                    Master.days[Workout.rawValue]?.add(exercise: Schedule.Routine.Exercise(Name: addName, Sets: Int(addSets)!, Reps: Int(addReps)!, Weight: Int(addWeight)!))
                    addName = ""
                    addWeight = ""
                    addReps = ""
                    addSets = ""
                    addingExercise = false
                }
                Button("Cancel") {
                    addName = ""
                    addWeight = ""
                    addReps = ""
                    addSets = ""
                    addingExercise = false
                }
            }
        }
        .padding()
    }
}

#Preview {
    workoutScreen(Workout: .pull)
}
