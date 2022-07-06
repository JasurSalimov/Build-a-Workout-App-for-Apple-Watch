//
//  WorkoutManager.swift
//  WorkoutApp(wwdc2018) WatchKit Extension
//
//  Created by Jasur Salimov on 7/6/22.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject{
    var selectedWorkout: HKWorkoutActivityType?{
        didSet{
            guard let selectedWorkout = selectedWorkout else {
                return
            }
            startWorkout(workoutType: selectedWorkout)
        }
    }
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    func startWorkout(workoutType: HKWorkoutActivityType){
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor

        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        }catch{
            // handle any exceptions
            return
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
        )
        
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(
            withStart: startDate){ (success, error) in
                //the workout has started
            }
    }
    
    func requestAuthorization(){
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        //The quantity types to read from the health store
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.activitySummaryType()
        ]
        
        // Request authorization for those quantity types
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            //handle error 
        }
        
    }
}
