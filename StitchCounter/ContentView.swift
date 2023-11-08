//
//  ContentView.swift
//  Stitch Counter
//
//  Created by Sam Cain on 10/18/23.
//

import SwiftUI

let IncreaseImage = VStack { Image("PlusSign")  }
let DecreaseImage = VStack { Image("MinusSign") }

func ClampValue(value: Int, range: Range<Int>) -> Int {
    if (value >= range.upperBound) { return range.upperBound - 1 }
    else if (value < range.lowerBound) { return range.lowerBound }
    return value
}

func ConvertDecimalToPercentage(decimal: Float) -> String {
    return String(Int(decimal * 100)) + "%"
}

struct CounterView: View {
    
    @Environment(\.colorScheme) var colorScheme
   
    @State private var i: Int
    @State private var pattern: Pattern
    @State private var section: Section
    @State private var count: Int
    @State private var step: Int = 1
    
    init(pattern: Pattern, index: Int = 0) {
        self._pattern = .init(initialValue: pattern)
        self._i = .init(initialValue: index)
        self._section = .init(initialValue: pattern.sections[index])
        self._count = .init(initialValue: pattern.sections[index].count)
    }
    
    func ResetCount() -> Void {
        section.count = 0
        count = section.count
    }
    
    func ChangeCount(increase: Bool) -> Void {
        
        if (section.count == section.rows && increase) {
            i = ClampValue(value: i + step, range: pattern.sections.indices);
            section = pattern.sections[i]
        }
        else if (section.count == 0 && !increase) {
            i = ClampValue(value: i - step, range: pattern.sections.indices);
            section = pattern.sections[i]
        }
        else {
            section.count = increase ? section.count + step : section.count - step
        }
        
        count = section.count
    }
    
    var body: some View {
        
        let total    = section.rows ?? 1
        let progress = Float(section.count) / Float(total)
        
        let circleInnerColor = (colorScheme == .dark) ? Color.white : Color.black
        let circleOuterColor = (colorScheme == .dark) ? Color.black : Color.white
        
        let circleInnerDiameter: CGFloat = 100
        let circleOuterDiameter: CGFloat = circleInnerDiameter * 1.10
        
        VStack {
            
            NavigationLink {
                SectionView(pattern: pattern)
            } label: {
                HStack {
                    Spacer()
                    Text("Sections")
                        .padding(.trailing)
                }
            }
            .navigationBarBackButtonHidden()
            
            Spacer()
            
            Text(section.name)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.mint)
            
            ProgressView(value: progress,
                         label: {
                Text(ConvertDecimalToPercentage(decimal: progress))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            )
            .padding(.bottom, 200)
            
            Text("Step = " + String(step))
            
            HStack {
                Text(String(count))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.mint)
                Text("of")
                Text(String(total))
                    .fontWeight(.bold)
            }
            .font(.system(size: 20))
            .foregroundColor(circleInnerColor)
            .background(Circle()
                .fill(circleOuterColor)
                .frame(width: circleInnerDiameter, height: circleInnerDiameter)
                .background(Circle()
                    .fill(circleInnerColor)
                    .frame(width: circleOuterDiameter, height: circleOuterDiameter)))
            .padding(.bottom, 50)
            
            Button(
                action: { ChangeCount(increase: true) },
                label:  { IncreaseImage }
            )
            
            Button(
                action: { ChangeCount(increase: false) },
                label:  {
                    if (colorScheme == .dark) { DecreaseImage.colorInvert()
                    } else {
                        DecreaseImage
                    }
                }
            )

            
            Button("Reset Count", action: { ResetCount() } )
            
        }
    }
}

#Preview {
    CounterView(pattern: Pattern.DefaultPattern())
}

