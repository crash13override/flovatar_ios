//
//  CountdownTimerView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 11.01.2022.
//

import SwiftUI

struct CountdownTimerView: View {
    
    let duration: Double
    @Binding var timeElapsed: Double
    @Binding var isActive: Bool
    @Binding var isPaused: Bool
    @Binding var isFinish: Bool
    
    @State private var counter: Double = 0

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var progressText: (Double, Double) {
        ((100 / duration) * counter, duration - counter)
    }
    
    var body: some View {
        ProgressCircleView(progressValue: progressText.0, textValue: progressText.1)
            .onReceive(timer) { _ in
                if isActive {
                    if counter >= duration {
                        timer.upstream.connect().cancel()
                        isFinish = true
                        counter = 0
                        timeElapsed = 0
                    } else {
                        if !isPaused {
                            counter += 1
                            timeElapsed += 1
                        }
                    }
                } else {
                    counter = 0
                    timeElapsed = 0
                }
            }
    }
}

#if DEBUG
struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.midnightBlue
            
            VStack(spacing: 20) {
                CountdownTimerView(duration: 5,
                                   timeElapsed: .constant(0),
                                   isActive: .constant(true),
                                   isPaused: .constant(false),
                                   isFinish: .constant(true))
                    .frame(width: 60, height: 60)
                
                CountdownTimerView(duration: 15,
                                   timeElapsed: .constant(0),
                                   isActive: .constant(false),
                                   isPaused: .constant(false),
                                   isFinish: .constant(true))
                    .frame(width: 80, height: 80)
                
                CountdownTimerView(duration: 12,
                                   timeElapsed: .constant(0),
                                   isActive: .constant(true),
                                   isPaused: .constant(false),
                                   isFinish: .constant(true))
                    .frame(width: 96, height: 96)
            }
        }
    }
}
#endif
