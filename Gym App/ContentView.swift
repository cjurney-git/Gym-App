//
//  ContentView.swift
//  Gym App
//
//  Created by Charlie Jurney on 11/17/24.
//

import SwiftUI
struct Schedule{
    var ID: Int?
    var Days: [String:Routine]
    struct Routine{
        var name: String
        var exercises: [String:Exercise]
        struct Exercise{
            var name: String
            var sets: Int
            var reps: Int
            var weight: Int
        }
    }
}

var Master = Schedule(ID:1, Days:[
    "none":Schedule.Routine(name:"",exercises:["":Schedule.Routine.Exercise(name:"",sets:0,reps:0,weight:0)]),
    "push":Schedule.Routine(name:"Push", exercises:["tricep extension":Schedule.Routine.Exercise(name:"tricep extension", sets:5, reps:11, weight:65)]),
    "pull":Schedule.Routine(name:"Pull", exercises:["preacher curl":Schedule.Routine.Exercise(name:"preacher curl", sets:5, reps:12, weight:50)]),
    "legs":Schedule.Routine(name:"Legs", exercises:["leg press":Schedule.Routine.Exercise(name:"leg press", sets:5, reps:11, weight:170)]),
    "chestBack":Schedule.Routine(name:"ChestBack", exercises:["pec fly":Schedule.Routine.Exercise(name:"pec fly", sets:5, reps:11, weight:60)]),
    "shouldersArms":Schedule.Routine(name:"ShouldersArms", exercises:["lateral raise":Schedule.Routine.Exercise(name:"lateral raise", sets:5, reps:11, weight:12)])
])


enum WorkoutType : String, CaseIterable{
    case none
    case push
    case pull
    case legs
    case chestBack
    case shouldersArms
}

struct ContentView: View {
    @State var Workout: WorkoutType = .none
    
    var body: some View {
        VStack {
            Text("select workout")
            Picker("select workout", selection: $Workout) {
                ForEach(WorkoutType.allCases, id: \.self) { workout in
                    Text(workout.rawValue)
                }
            }
            NavigationView{
                NavigationLink(destination: workoutScreen(Workout: Workout)){Text("GO")}
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
