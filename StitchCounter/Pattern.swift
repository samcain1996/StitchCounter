//
//  Pattern.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/20/23.
//

import Foundation


class Section: Identifiable, ObservableObject {
    @Published var name: String
    @Published var rows: Int?
    @Published var count: Int
    
    init(name: String = "", rows: Int? = nil) {
        self.name = name
        self.rows = rows
        self.count = 0
    }
    
    static func IsInitialized(section: Section) -> Bool {
        return section.name != "" && section.rows != nil
    }
    
    static func DefaultSections() -> [Section] {
        return [Section(name: "Test", rows: 100), Section(name: "Another Test", rows: 25)]
    }
}

class Pattern: ObservableObject {
    
    @Published var sections: [Section]
    
    init(sections: [Section] = [Section()]) {
        self.sections = sections
    }
    
    static func DefaultPattern() -> Pattern {
        return Pattern(sections: Section.DefaultSections())
    }
    
}
