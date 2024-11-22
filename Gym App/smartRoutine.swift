//
//  smartRoutine.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/21/24.
//

import SwiftUI
struct smartRoutine: View {
    var workout: String
    var routine: Schedule.Routine
    var schedule: Schedule
    @State var currExercise : Int = 0
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        if(numCompleted<routine.exercises.count){
                let keys = Array(routine.exercises.keys)
                VStack {
                    if(!(completedArr[keys[currExercise]] ?? false)){
                        Text(routine.exercises[keys[currExercise]]!.name)
                    }
                    else{
                        Text("COMPLETED \(routine.exercises[keys[currExercise]]!.name)").foregroundStyle(.red)
                            .onAppear{while(completedArr[keys[currExercise]] ?? false){
                                currExercise += 1
                                print("comp\(currExercise)")
                            }
                                if(currExercise==currExercise){currExercise = currExercise}}
                    }
                    // Text("Machine: \(currExercise.machine)")
                    NavigationStack{
                        NavigationLink(destination: exerciseScreen(workout: workout, schedule: schedule,exercise: routine.exercises[routine.exercises[keys[currExercise]]!.name])){Text("Continue").onAppear{
                            //currExercise += 1;currExercise=0;print("nav\(currExercise)")
                        }}.simultaneousGesture(TapGesture().onEnded(){
                            currExercise = 0
                        })
                    }
                }
                Button("Next"){
                    currExercise += 1
                }.disabled(!(currExercise<keys.count-numCompleted-1))
            }
            else {
                Text("Finished!")
                Button("Close"){
                    dismiss()
                    dismiss()
                }
            }
        }
    }


#Preview {
    let test: Schedule = Schedule(Days: ["Pull":Schedule.Routine(Name: "Pull",
    Exercises: ["Lat Pulldown":Schedule.Routine.Exercise(Name: "Lat Pulldown", Sets: 11, Reps: 4, Weight: 65), "Preacher Curl":Schedule.Routine.Exercise(Name: "Preacher Curl", Sets: 3, Reps: 12, Weight: 50), "Rear Delt Fly":Schedule.Routine.Exercise(Name: "Rear Delt Fly", Sets: 5, Reps: 12, Weight: 55)])])
                                         
    smartRoutine(workout: "Pull", routine: test.days["Pull"]!, schedule: test)
}
