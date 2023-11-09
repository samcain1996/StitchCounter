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
    if (value >= range.upperBound) { return range.upperBound - 1 }
    else if (value < range.lowerBound) { return range.lowerBound }
    return value
}

func ConvertDecimalToPercentage(_ decimal: Float) -> String {
    return String(Int(decimal * 100)) + "%"
}

struct CounterView: View {
    
    @Environment(\.colorScheme) var colorScheme
   
    @State private var i: Int
    @State private var pattern: Pattern
    @State private var section: Section
    @State private var count: Int
    @State private var step: Int
    
    init(pattern: Pattern, index: Int = 0) {
        self._i       = .init(initialValue: index)
        self._pattern = .init(initialValue: pattern)
        self._section = .init(initialValue: pattern.sections[index])
        self._count   = .init(initialValue: pattern.sections[index].count)
        self._step    = .init(initialValue: 1)
    }
    
    // Reset count of current section to 0
    func ResetCount() -> Void {
        section.count = 0
        count = section.count
    }
    
    // Increase or decrease the stitch count of the current section
    func ChangeCount(increase: Bool) -> Void {
        
        if (section.count == section.rows && increase) {  // Go to next section
            i = ClampValue(value: i + 1, range: pattern.sections.indices);
            section = pattern.sections[i]

        }
        else if (section.count == 0 && !increase) {  // Go back a section
            i = ClampValue(value: i - 1, range: pattern.sections.indices);
            section = pattern.sections[i]
        }
        else {  // Increase current section's count
            let countRange: Range<Int> = 0..<( ( section.rows ?? 1 ) + 1 )
            section.count = increase ? 
                ClampValue(value: section.count + step, range: countRange) :
                ClampValue(value: section.count - step, range: countRange)
        }
        
        count = section.count
    }
    
    var body: some View {
        
        // Percent complete of current section
        let total    = section.rows ?? 1
        let progress = Float(section.count) / Float(total)
        
        // Information needed for drawing circle with count in it
        let circleInnerColor = (colorScheme == .dark) ? Color.white : Color.black
        let circleOuterColor = (colorScheme == .dark) ? Color.black : Color.white
        
        let circleInnerDiameter: CGFloat = 100
        let circleOuterDiameter: CGFloat = circleInnerDiameter * 1.10
        
        VStack {
            
            // Show all sections in pattern
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
            
            // Section name and progress
            Text(section.name)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.mint)
            
            ProgressView(value: progress,
                         label: {
                Text(ConvertDecimalToPercentage(progress))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            )
            .padding(.bottom, 150)
            
            // Show current amount out of total rows for section
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
            .padding(.bottom, 60)
            
            // Increase count
            Button(
                action: { ChangeCount(increase: true) },
                label:  { IncreaseImage }
            )
            
            // Decrease count
            Button(
                action: { ChangeCount(increase: false) },
                label:  {
                    // Change color of button depending on color scheme
                    if (colorScheme == .dark) { DecreaseImage.colorInvert() }
                    else { DecreaseImage }
                }
            )

            HStack {
                Button("Reset Count", action: { ResetCount() } )
                    .frame(minWidth: 120)
                
                // Adjust the amount of steps that count changes by when updated
                Text("step  " + String(step))
                VStack {
                    Button("+", action: { step = step + 1 })
                        .disabled(step >= 10)
                    Button("-", action: { step = step - 1 })
                        .disabled(step < 2)
                }
            }
            
        }
    }
}

#Preview {
    CounterView(pattern: Pattern.DefaultPattern())
}

