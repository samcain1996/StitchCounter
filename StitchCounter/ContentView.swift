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

struct ContentView: View {
    
    @State private var count : Int = 0
    @State private var total : Int = 100
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {

        let progress = Float(count) / Float(total)
        
        let circleInnerColor = (colorScheme == .dark) ? Color.white : Color.black
        let circleOuterColor = (colorScheme == .dark) ? Color.black : Color.white
        
        VStack {

            ProgressView(value: progress, label: { Text(String(Int(progress * 100)) + "%").frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)})
                .padding(.bottom, 200)
            
            Text(String(count))
                .font(.system(size: 20))
                .foregroundColor(circleInnerColor)
                .background(Circle().fill(circleOuterColor).frame(width: 100, height: 100).background(Circle().fill(circleInnerColor).frame(width: 110, height: 110)))
                .padding(.bottom, 50)
            
            Button(action: { count = ClampValue(value: count + 1, range: Range<Int>(0...total)) }, label: { IncreaseImage } )
            
            if (colorScheme == .light) {
                Button(action: { count = ClampValue(value: count - 1, range: Range<Int>(0...total)) }, label: { DecreaseImage } )
            }
            else {
                Button(action: { count = ClampValue(value: count - 1, range: Range<Int>(0...total)) }, label: { DecreaseImage.colorInvert() } )
            }
            
            Button("Reset Count", action: { count = 0 } )
            
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
