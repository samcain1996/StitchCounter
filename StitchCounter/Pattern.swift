//
//  Pattern.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/20/23.
//

import Foundation

class Section: Identifiable, ObservableObject {
    @Published var name: String = ""
    @Published var rowCount: Int? = nil
}

class Pattern: ObservableObject {
    @Published var sections: [Section] = [Section()]
}
