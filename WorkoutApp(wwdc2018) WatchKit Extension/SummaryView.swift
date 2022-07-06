//
//  SummaryView.swift
//  WorkoutApp(wwdc2018) WatchKit Extension
//
//  Created by Jasur Salimov on 7/6/22.
//

import SwiftUI

struct SummaryView: View {
    @State private var durationFormatter:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading){
                SummaryMetricView(
                    title: "Total Time", value: durationFormatter.string(for: 30*60 + 15) ?? "").tint(Color.yellow)
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
                ).tint(Color.green)
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
                ).tint(Color.pink)
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
