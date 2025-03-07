//
//  CCValidatorApp.swift
//  CCValidator
//
//  Created by mac on 5.03.25.
//

import SwiftUI

@main
struct CCValidatorApp: App {
    var body: some Scene {
        WindowGroup {
            CardInputView(viewModel: CardViewModel())
        }
    }
}
