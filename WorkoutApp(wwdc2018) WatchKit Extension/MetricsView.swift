//
//  MetricsView.swift
//  WorkoutApp(wwdc2018) WatchKit Extension
//
//  Created by Jasur Salimov on 7/6/22.
//

import SwiftUI

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var body: some View {
        VStack(alignment: .leading){
            ElapsedTimeView(
                elapsedTime: workoutManager.builder?.elapsedTime ?? 0, showSubseconds: true
            ).foregroundColor(Color.yellow)
            Text(
                Measurement(
                    value: workoutManager.activeEnergy,
                    unit: UnitEnergy.kilocalories
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .workout,
                        numberFormatStyle: .number
                    )
                )
            )
            Text(
                workoutManager.heartRate.formatted(
                    .number.precision(.fractionLength(0))
                )
                + " bpm"
            )
            Text(
            Measurement(
                value: workoutManager.distance,
                unit: UnitLength.meters
            ).formatted(
                .measurement(
                    width: .abbreviated,
                    usage: .road
                 )
              )
            )
        }
        .font(.system(.title, design: .rounded)
            .monospacedDigit()
            .lowercaseSmallCaps()
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .scenePadding()
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
    }
}
//
//
//private struct MetricsTimeLineSchedule: TimelineSchedule{
//  
//  
//    
//    var startDate: Date
//    
//    init(from startDate: Date){
//        self.startDate = startDate
//    }
//    
//    func entries(from startDate: Date, mode: Mode) -> some Sequence {
//        PeriodicTimelineSchedule.Entries{
//            PeriodicTimelineSchedule(
//                from: self.startDate,
//                by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0)
//            ).entries(
//                from: startDate,
//                mode: mode)
//        }
//    }
//}
