//
//  ContentView.swift
//  Stitch Counter
//
//  Created by Sam Cain on 10/18/23.
//

import SwiftUI

let IncreaseImage = Image("PlusSign")
let DecreaseImage = Image("MinusSign")

func ClampValue(value: Int, range: Range<Int>) -> Int {
    if (value > range.upperBound) { return range.upperBound }
    else if (value < range.lowerBound) { return range.lowerBound }
    return value
}

struct CounterView: View {
    
    @State private var count: Int = 0
    @State private var i: Int = 0
    @State var pattern: Pattern

    @Environment(\.colorScheme) var colorScheme
    
    func ChangeCounter(increase: Bool) -> Void {
        let rowCount = pattern.sections[i].rowCount ?? 1
        count = increase ? count + 1 : count - 1
        
        if (count < 0) {
            i = ClampValue(value: i - 1, range: 0..<pattern.sections.count)
            count = pattern.sections[i].rowCount ?? rowCount
        }
        else if (count >= rowCount) {
            i = ClampValue(value: i + 1, range: 0..<pattern.sections.count)
            count = 0
        }
    }
    
    var body: some View {
        
        var section = pattern.sections[i]
        let rowCount = section.rowCount ?? 1
        let progress = Float(count) / Float(rowCount)
        
        let circleInnerColor = (colorScheme == .dark) ? Color.white : Color.black
        let circleOuterColor = (colorScheme == .dark) ? Color.black : Color.white

        VStack {
            
            Text(section.name)
            ProgressView(value: progress, label: { Text(String(Int(progress * 100)) + "%").frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)})
                .padding(.bottom, 200)
            
            Text(String(count) + " / " + String(rowCount))
                .font(.system(size: 20))
                .foregroundColor(circleInnerColor)
                .background(Circle().fill(circleOuterColor).frame(width: 100, height: 100).background(Circle().fill(circleInnerColor).frame(width: 110, height: 110)))
                .padding(.bottom, 50)
            
            Button(action: { ChangeCounter(increase: true) },
                   label:  { IncreaseImage } )
            
            if (colorScheme == .light) {
                Button(action: { ChangeCounter(increase: false) },
                       label: { DecreaseImage } )
            }
            else {
                Button(action: { ChangeCounter(increase: false) },
                       label: { DecreaseImage.colorInvert() } )
            }
            
            Button("Reset Count", action: { count = 0 } )
            
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

