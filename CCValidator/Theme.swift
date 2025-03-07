//
//  Theme.swift
//  CCValidator
//
//  Created by mac on 6.03.25.
//

import SwiftUI

struct Theme {
    struct Colors {
        static let backgroundColor = Color(red: 96/255, green: 74/255, blue: 130/255)
        static let textColor = Color.white
    }
    
    struct Gradients {
        static let validGradient = Gradient(name: "validGradient", value: LinearGradient(
            colors: [.blue, .cyan, .green],
            startPoint: .topLeading,
            endPoint: .bottomTrailing))
        static let invalidGradient = Gradient(name: "invalidGradient", value: LinearGradient(
            colors: [.blue, .cyan, .red],
            startPoint: .topLeading,
            endPoint: .bottomTrailing))
        
        struct Gradient {
            let id = UUID()
            let name: String
            let value: LinearGradient
        }
    }
    
    enum Symbols {
        static let checkmark = "checkmark.circle.fill"
        static let xCircle = "x.circle.fill"
    }

    enum Strings {
        static let enterCardNumber = "Enter card number"
        static let valid = "Valid"
        static let invalid = "Invalid"
    }
}
