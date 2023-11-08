//
//  SectionView.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/23/23.
//

import SwiftUI

struct SectionView: View {
    
    @State var pattern: Pattern
    
    init(pattern: Pattern) {
        self._pattern = .init(initialValue: pattern)
    }
    
    var body: some View {
        
            VStack {
                
                List(pattern.sections.indices, id:\.self) { index in
                    
                    NavigationLink {
                        CounterView(pattern: pattern, index: index)
                    } label: {
                        HStack {
                            let section = pattern.sections[index]
                            let rows = section.rows ?? 1
                            
                            Text(section.name)
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(width: 170, alignment: .leading)
                            Text(String(section.count))
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("of")
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text(String(rows))
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
