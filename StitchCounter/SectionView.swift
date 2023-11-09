//
//  SectionView.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/23/23.
//

import SwiftUI

// Display all sections in pattern
struct SectionView: View {
    
    @State var pattern: Pattern
    
    init(pattern: Pattern) {
        self._pattern = .init(initialValue: pattern)
    }
    
    var body: some View {
        
            VStack {
                
                // Edit sections in pattern
                NavigationLink("Edit Pattern") {
                    CreateView(pattern: pattern)
                }
                
                // List all sections and how complete they are
                List(pattern.sections.indices, id:\.self) { index in
                    
                    NavigationLink {
                        CounterView(pattern: pattern, index: index)
                    } label: {
                        
                        HStack {
                            let section = pattern.sections[index]
                            let rows = section.rows ?? 0
                            
                            // Section
                            Text(section.name)
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(width: 170, alignment: .leading)
                            
                            // Amount complete
                            Text(String(section.count) + " of " + String(rows))
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                
                        }
                        
                    }
                    
                }
                
            }
        
    }
}

#Preview {
    SectionView(pattern: Pattern.DefaultPattern())
}
