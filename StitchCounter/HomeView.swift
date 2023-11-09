//
//  HomeView.swift
//  StitchCounter
//
//  Created by Sam Cain on 11/8/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            
            VStack {
                NavigationLink("Create Pattern") {
                    CreateView(allowCreate: true)
                }
                NavigationLink("Load Pattern") {
                    LoadView()
                }
            }
        }

    }
}


struct LoadView: View {
    
    @State private var patterns: [Pattern] = [Pattern.DefaultPattern()]
    
    init() {
    
        // Create directory if it doesn't already exist
        if (!filemanager.fileExists(atPath: patternsURL.path)) {
            do {
                try filemanager.createDirectory(at: patternsURL, withIntermediateDirectories: true)
            } catch {
                return
            }
        }
        
        patterns = FetchSavedPatterns()
        
    }

    var body: some View {
        
        VStack {
            
            List(patterns, id:\.name) { pattern in
                
                VStack {
                    
                    HStack {
                        NavigationLink(destination: CounterView(pattern: Pattern(pattern.name, sections: Section.DefaultSections())), label: {
                            Text(pattern.name)
                                .frame(minWidth: 250, alignment: .leading)
                        })
                        Button("Delete", action: {
                            DeletePattern(pattern.name)
                            patterns.removeAll { p in
                                p.id == pattern.id
                            }
                        })
                        .frame(alignment: .trailing)
                    }
                }
            }
        }
        
    }
}

#Preview {
    LoadView()
}
