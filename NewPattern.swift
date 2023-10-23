//
//  NewPattern.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/21/23.
//

import SwiftUI

struct PatternEntry: View {
    @EnvironmentObject var model: Section
    
    var body: some View {
        HStack {
            TextField("Section Name", text: $model.name)
            TextField("Rows", value: $model.rowCount, format: .number)
        }
    }
}

struct CreateView: View {
    
    @StateObject private var pattern = Pattern()
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(pattern.sections) { sec in
                    PatternEntry().environmentObject(sec)
                }
                Button("Add", action: {
                    pattern.sections.append(Section())
                    
                })
                NavigationLink("Create") {
                    CounterView(pattern: pattern)
                }
            }
        }
    }
    
}

#Preview {
    CreateView()
}
