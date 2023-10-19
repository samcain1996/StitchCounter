//
//  ContentView.swift
//  Stitch Counter
//
//  Created by Sam Cain on 10/18/23.
//

import SwiftUI


struct ContentView: View {
    @State private var count : Int = 0
    @State private var total : Int = 100
    var body: some View {
        
        let x = Float(count)
        let y = Float(total)
        let progress = x / y
        
        VStack {
            ProgressView(value: progress)
            Text(String(count))
                .font(.system(size: 20))
                .foregroundColor(Color.black)
                .background(Circle().fill(Color.white).frame(width: 100, height: 100).background(Circle().fill(Color.black).frame(width: 110, height: 110)))
            Button(action: {count += 1}, label: {Image("Increase")})
            Button(action: {count -= 1}, label: {Image("Decrease")})
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
