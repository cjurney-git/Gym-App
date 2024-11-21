//
//  exerciseScreen.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/18/24.
//

import SwiftUI


struct exerciseScreen: View {
    var Workout: String
    var schedule: Schedule
    @State var metricController: Bool = false
    @State var exercise: Schedule.Routine.Exercise?
    @State var redraw: Int = 0
    @State var setsComp: Int = 0
    @State var exerciseCompleted: Bool = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            if(metricController == false && exerciseCompleted == false){
                Text(exercise!.name)
                Button("start exercise") {
                    schedule.progOverload(exercise: exercise!)
                    metricController = true
                }
            }
            
            if(metricController) {
                Text("Exercise: \(exercise!.name)")
                Text("Weight: \(exercise!.weight) lbs")
                Text("Reps: \(exercise!.reps)\n\n")
                if(exerciseCompleted==false){
                    Button("Set Completed") {
                        if(setsComp<4){
                            setsComp += 1
                        }
                        else{
                            setsComp += 1
                            exerciseCompleted = true
                            metricController = false
                            exercise?.setSets(sets: setsComp)
                        }
                    }
                    Text("\n")
                    Button("Set Failed") {
                        exerciseCompleted = true
                        metricController = false
                        exercise?.setSets(sets: setsComp)
                    }
                    Text("\n\nSets Completed: \(setsComp)")
                }
                
            }
            if(metricController == false && exerciseCompleted == true) {
                Text("Exercise Completed")
                Text("Sets Completed: \(setsComp)")
                if(setsComp==5){
                    Text("Great Job!")
                }
                Button("Return to \(Workout)"){
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let test: Schedule = Schedule(Days: ["Pull":Schedule.Routine(Name: "Pull", Exercises: ["Lat Pulldown":Schedule.Routine.Exercise(Name: "Lat Pulldown", Sets: 5, Reps: 12, Weight: 65)])])
    exerciseScreen(Workout: "Pull", schedule: test, exercise: test.days["Pull"]!.exercises["Lat Pulldown"]!)
}
