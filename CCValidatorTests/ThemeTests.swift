//
//  ThemeTests.swift
//  CCValidatorTests
//
//  Created by mac on 5.03.25.
//

import Testing
import SwiftUI
@testable import CCValidator

struct ThemeTests {
    @Test
    func testBackgroundColor() {
        let backgroundColor = Theme.Colors.backgroundColor
        #expect(backgroundColor == Color(red: 96/255, green: 74/255, blue: 130/255))
    }
    
    @Test
    func testTextColor() {
        let textColor = Theme.Colors.textColor
        #expect(textColor == .white)
    }
    
    @Test
    func testValidGradient() {
        let gradient = Theme.Gradients.validGradient
        #expect(gradient.name == "validGradient")
    }
    
    @Test
    func testInvalidGradient() {
        let gradient = Theme.Gradients.invalidGradient
        #expect(gradient.name == "invalidGradient")
    }
    
    @Test
    func testSymbols() {
        #expect(Theme.Symbols.checkmark == "checkmark.circle.fill")
        #expect(Theme.Symbols.xCircle == "x.circle.fill")
    }
    
    @Test
    func testStrings() {
        #expect(Theme.Strings.enterCardNumber == "Enter card number")
        #expect(Theme.Strings.valid == "Valid")
        #expect(Theme.Strings.invalid == "Invalid")
    }
}
