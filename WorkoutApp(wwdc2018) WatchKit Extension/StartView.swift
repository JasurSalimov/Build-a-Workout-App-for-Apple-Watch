//
//  ContentView.swift
//  WorkoutApp(wwdc2018) WatchKit Extension
//
//  Created by Jasur Salimov on 7/6/22.
//

import SwiftUI
import HealthKit

struct StartView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var workoutType: [WorkoutType] = [
        WorkoutType(type: .cycling, name: "Cycling"),
        WorkoutType(type: .walking, name: "Walking"),
        WorkoutType(type: .running, name: "Running")
    ]
    
    var body: some View {
        List(workoutType){ type in
            NavigationLink(
                type.name,
                destination: SessionPagingView(),
                tag: type.type,
                selection: $workoutManager.selectedWorkout
            ).padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
        }
        .listStyle(.carousel)
        .navigationTitle("Workouts")
        .onAppear{
            workoutManager.requestAuthorization()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

struct WorkoutType: Identifiable{
    var id = UUID()
    var type: HKWorkoutActivityType
    var name: String
    
    init(type: HKWorkoutActivityType, name: String){
        self.type = type
        self.name = name
    }
    
}
