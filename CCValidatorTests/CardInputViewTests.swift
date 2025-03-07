//
//  CardInputViewTests.swift
//  CCValidatorTests
//
//  Created by mac on 5.03.25.
//

import Testing
import SwiftUI
import ViewInspector

@testable import CCValidator

@MainActor
struct CardInputViewTests {
    typealias Validator = CCValidator.CardValidatorRepresentable

    @Test
    func testViewHasTextField() throws {
        let validator = MockCardValidator()
        let viewModel = MockCardValidatorModel(validator: validator)
        let view = CardInputView(viewModel: viewModel)

        let textField = try view.inspect().find(ViewType.TextField.self)
        #expect(textField != nil)
    }

    @Test
    func testViewHasValidationText() throws {
        let validator = MockCardValidator()
        let viewModel = MockCardValidatorModel(validator: validator)
        let view = CardInputView(viewModel: viewModel)

        let text = try view.inspect().find(text: Theme.Strings.valid)
        #expect(text != nil)
    }

    @Test
    func testViewDisplaysCorrectImageForBrand() throws {
        let validator = MockCardValidator()
        let viewModel = MockCardValidatorModel(validator: validator)
        let view = CardInputView(viewModel: viewModel)

        let image = try view.inspect().find(ViewType.Image.self)
        #expect(image != nil)
    }
}

// MARK: - Mocks

extension CardInputViewTests {
    class MockCardValidator: CardValidatorRepresentable {
        func detectCardType(from number: String) -> CardType { .visa }
        func isValidCard(_ number: String) -> Bool { true }
    }
    
    class MockCardValidatorModel: CardViewModelRepresentable {
        @Published var cardNumber: String = ""
        var validator: any Validator
        var cardType: CardType = .visa
        var isValid: Bool = true
        var brandImageName: String? = "visa"
        
        func detectCardType(from number: String) -> CardType { .visa }
        func isValidCard(_ number: String) -> Bool { true }
        func limitUserInput(value: String) { }
        
        init(validator: any Validator) {
            self.validator = validator
        }
    }
}
