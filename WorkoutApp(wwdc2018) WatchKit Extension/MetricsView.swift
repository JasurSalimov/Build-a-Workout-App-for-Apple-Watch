//
//  MetricsView.swift
//  WorkoutApp(wwdc2018) WatchKit Extension
//
//  Created by Jasur Salimov on 7/6/22.
//

import SwiftUI

struct MetricsView: View {
    var body: some View {
        VStack(alignment: .leading){
            ElapsedTimeView(
                elapsedTime: 3*60 + 15.24, showSubseconds: true
            ).foregroundColor(Color.yellow)
            Text(
                Measurement(
                    value: 47,
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
                153.formatted(
                    .number.precision(.fractionLength(0))
                )
                + " bpm"
            )
            Text(
            Measurement(
                value: 515,
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
