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
            Spacer()
            
            TextField("Section Name", text: $model.name)
                .textFieldStyle(.roundedBorder)
                .frame(width: 225)
            
            TextField("Rows", value: $model.rows, format: .number)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
        }
    }
}

struct CreateView: View {
    
    @State private var rows: Int
    @StateObject private var pattern: Pattern
    
    init(pattern: Pattern = Pattern()) {
        self._rows = .init(initialValue: 1)
        self._pattern = .init(wrappedValue: pattern)
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ForEach(pattern.sections) { section in
                    
                    HStack {
                        PatternEntry().environmentObject(section)
                        Button("Remove", action: {
                            pattern.sections.removeAll { sec in
                                sec.id == section.id
                            }
                        })
                        .foregroundStyle(.red)
                    }
                    
                }
                
                Button("Add", action: {
                    pattern.sections.append(Section())
                }).padding(.top)
                
                Spacer()
                
                NavigationLink(
                    destination: { CounterView(pattern: pattern) },
                    label: { Text("Create Pattern") }
                )
                .disabled( !pattern.sections.contains(where: Section.IsInitialized) )
            }
        }
    }
    
}

#Preview {
    CreateView(pattern: Pattern.DefaultPattern())
}
