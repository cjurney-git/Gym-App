//
//  workoutScreen.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/17/24.
//

import SwiftUI

var testle : String = "pec fly"

enum munkleExercise : String, CaseIterable {
    case tricepExtension
    case legPress
    case testle
}

struct workoutScreen: View {
    var Workout: WorkoutType
    var body: some View {
        let routine: Schedule.Routine = Master.Days[Workout.rawValue]!
        var exSet: [String:Schedule.Routine.Exercise] = routine.exercises
        @State var selectedExercise: munkleExercise = .tricepExtension
        VStack {
            Text("Workout: \(routine.name)\n")
//            Text("Exercise: \(routine.exercises[0].name)")
//            Text("Weight: \(routine.exercises[0].weight) lbs")
//            Text("Reps: \(routine.exercises[0].reps)")
//            Text("Sets: \(routine.exercises[0].sets)")
            Picker("Select an Exercise", selection: $selectedExercise) {
                ForEach(munkleExercise.allCases, id: \.self){ exercise in 
                    Text(exercise.rawValue)
                }
            }
        }
        .padding()
    }
}

#Preview {
    workoutScreen(Workout: .push)
}
