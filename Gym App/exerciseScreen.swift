//
//  exerciseScreen.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/18/24.
//

import SwiftUI



struct exerciseScreen: View {
    var Workout: String
    @State var metricController: Bool = false
    @State var exercise: Schedule.Routine.Exercise?
    @State var redraw: Int = 0
    @State var setsComp: Int = 0
    @State var exerciseCompleted: Bool = false
    var body: some View {
        VStack {
            if(metricController == false && exerciseCompleted == false){
                Text(exercise!.name)
                Button("start exercise") {
                    Master.progOverload(Workout: exercise!.name, exercise: exercise!)
                    
                    // GET RID OF THIS (find diff way to force redraw)
                    let temp = exercise
                    exercise = Schedule.Routine.Exercise()
                    exercise = temp
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
            }
        }
        
        
        
    }
}


#Preview {
    exerciseScreen(Workout: "push", exercise: Master.days["push"]!.exercises["tricep extension"]!)
}
