//
//  Pattern.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/20/23.
//

import Foundation

// Represents one section of a larger knitting pattern
class Section: Identifiable, ObservableObject {
    
    @Published var name: String
    @Published var rows: Int?
    @Published var count: Int
    
    init(name: String = "", rows: Int? = nil) {
        self.name = name
        self.rows = rows
        self.count = 0
    }
    
    static func IsInitialized(_ section: Section) -> Bool {
        return section.name != "" || section.rows != nil
    }
    
    // Default section list used for testing
    static func DefaultSections() -> [Section] {
        return [Section(name: "Test", rows: 17), Section(name: "Another", rows: 12)]
    }
}

// Collection of sections that represent an entire knitting pattern
class Pattern: ObservableObject {
    
    @Published var sections: [Section]
    
    init(sections: [Section] = [Section()]) {
        self.sections = sections
    }
    
    // Default pattern used for testing
    static func DefaultPattern() -> Pattern {
        return Pattern(sections: Section.DefaultSections())
    }
    
}
