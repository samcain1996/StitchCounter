//
//  StitchCounterApp.swift
//  StitchCounter
//
//  Created by Sam Cain on 10/18/23.
//

import SwiftUI

@main
struct StitchCounterApp: App {
    var body: some Scene {
        WindowGroup {
            CreateView(pattern: Pattern.DefaultPattern())
        }
    }
}
