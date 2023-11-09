//
//  NewPattern.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/21/23.
//

import SwiftUI

// Entry form for a new pattern section
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

// View to create a new pattern
struct CreateView: View {
    
    @StateObject private var pattern: Pattern
    
    init(pattern: Pattern = Pattern()) {
        self._pattern = .init(wrappedValue: pattern)
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // List each section
                ForEach(pattern.sections) { section in
                    
                    HStack {
                        PatternEntry().environmentObject(section)
                        Button("Remove", action: {
                           
                                pattern.sections.removeAll { sec in
                                    sec.id == section.id
                                }
                            
                        })
                        .foregroundStyle(pattern.sections.count > 1 ? .red : .gray)
                        .disabled(pattern.sections.count < 2)
                    }
                    
                }
                
                // Add new section
                Button("Add", action: {
                    pattern.sections.append(Section())
                })
                .padding(.top)
                
                Spacer()
                
                // Create pattern only if all boxes are filled correctly
                NavigationLink(
                    destination: { CounterView(pattern: pattern) },
                    label: { Text("Create Pattern") }
                )
                .disabled( !pattern.sections.allSatisfy(Section.IsInitialized) )
            }
        }
    }
    
}

#Preview {
    CreateView(pattern: Pattern.DefaultPattern())
}
