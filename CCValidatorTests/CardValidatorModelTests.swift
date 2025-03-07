//
//  CardViewModelTests.swift
//  CCValidatorTests
//
//  Created by mac on 5.03.25.
//

import Testing
@testable import CCValidator

class CardViewModelTests {
    var mockValidator: MockCardValidator!
    var viewModel: CardViewModel!
    
    init() {
        mockValidator = MockCardValidator()
        viewModel = CardViewModel(validator: mockValidator)
    }
    
    deinit {
        mockValidator = nil
        viewModel = nil
    }
    
    @Test
    func testCardTypeDetection() {
        mockValidator.detectedCardType = .visa
        #expect(viewModel.cardType == .visa)
        
        mockValidator.detectedCardType = .amex
        #expect(viewModel.cardType == .amex)
    }
    
    @Test
    func testCardValidation() {
        mockValidator.validationResult = true
        mockValidator.detectedCardType = .masterCard
        #expect(viewModel.isValid)
        
        mockValidator.validationResult = false
        #expect(!viewModel.isValid)
    }
    
    @Test
    func testLimitUserInput() {
        let longInput = "123456789012345678901234567890"
        viewModel.limitUserInput(value: longInput)
        #expect(viewModel.cardNumber.count == 20)
        
        let nonNumericInput = "abcd1234efgh5678"
        viewModel.limitUserInput(value: nonNumericInput)
        #expect(viewModel.cardNumber == "12345678")
    }
}

// MARK: - Mocks

extension CardViewModelTests {
    class MockCardValidator: CardValidatorRepresentable {
        var detectedCardType: CardType = .unknown
        var validationResult: Bool = false
        var cardNumber: String = ""
        
        func detectCardType(from number: String) -> CardType {
            return detectedCardType
        }
        
        func isValidCard(_ number: String) -> Bool {
            return validationResult
        }
    }
}
