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
class Pattern: ObservableObject, Identifiable {
    
    @Published var name:     String
    @Published var sections: [Section]
    
    init(_ name: String, sections: [Section] = [Section()]) {
        self.name     = name
        self.sections = sections
    }
    
    // Default pattern used for testing
    static func DefaultPattern() -> Pattern {
        return Pattern("Default Pattern", sections: Section.DefaultSections())
    }
    
}

let foldername  = "StitchCounterPatterns"
let patternsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(foldername)
let filemanager = FileManager.default

func FetchSavedPatterns() -> [Pattern] {
    
    var savedPatterns: [Pattern] = []
    
    do {
        let files = try filemanager.contentsOfDirectory(at: patternsURL, includingPropertiesForKeys: nil)
        
        for patternFile in files {
            
            let content = try String(contentsOf: patternFile)
            savedPatterns.append(Pattern(content))
            
        }
        
    } catch { }
    
    return savedPatterns
    
}

@discardableResult
func SavePattern(_ pattern: Pattern) -> Bool {
    
    do {
        try pattern.name.write(to: patternsURL.appendingPathComponent(pattern.name + ".txt"), atomically: true, encoding: String.Encoding.utf8)
    } catch {
        return false
    }
    return true
}

@discardableResult
func DeletePattern(_ patternName: String) -> Bool {
    
    let url = patternsURL.appendingPathComponent(patternName + ".txt")
    
    if (filemanager.fileExists(atPath: url.path)) {
        do {
            try filemanager.removeItem(at: url)
        } catch { return false }
        
        return true
    }
    
    return false
}
