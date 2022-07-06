//
//  SummaryView.swift
//  WorkoutApp(wwdc2018) WatchKit Extension
//
//  Created by Jasur Salimov on 7/6/22.
//

import SwiftUI
import HealthKit
struct SummaryView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    @State private var durationFormatter:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        if workoutManager.workout == nil{
            ProgressView("Saving workout")
                .navigationBarHidden(true)
        }else{
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    SummaryMetricView(
                        title: "Total Time",
                        value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0.0) ?? "") .accentColor(Color.yellow)
                    SummaryMetricView(
                        title: "TotalDistance", value: Measurement(
                            value: 1625,
                            unit: UnitLength.meters
                        ).formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .road
                            )
                        )
                    ).accentColor(Color.green)
                    SummaryMetricView(
                        title: "Total Energy",
                        value: Measurement(
                            value: 96,
                            unit: UnitEnergy.kilocalories
                        ).formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .workout,
                                numberFormatStyle: .number)
                        )
                    ).accentColor(Color.pink)
                    SummaryMetricView(
                        title: "Avg. Heart Rate",
                        value: 143
                            .formatted(
                                .number.precision(.fractionLength(0))
                            )
                            + " bpm"
                    ).accentColor(Color.pink)
                    Text("Activity Rings")
                    ActivityRingsView(healthStore: HKHealthStore()
                    ).frame(width: 50, height:50)
                    Button("Done"){
                        dismiss()
                    }
                    .scenePadding()
                }
                .navigationTitle("Summary")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}


struct SummaryMetricView: View{
    var title: String
    var value: String
    
    var body: some View{
        Text(title)
        Text(value)
            .font(.system(.title2, design: .rounded)
                .lowercaseSmallCaps()
            )
            .foregroundColor(.accentColor)
        Divider()
    }
}
