//
//  DefaultCardValidatorTests.swift
//  CCValidatorTests
//
//  Created by Philip Plamenov on 5.03.25.
//

import Testing
@testable import CCValidator

final class DefaultCardValidatorTests {
    var validator: DefaultCardValidator!
    let validVisa = "4111111111111111"
    let validMasterCard = "5105105105105100"
    let validDiscover = "6011111111111117"
    let validAmex = "378282246310005"
    
    init() {
        validator = DefaultCardValidator()
    }
    
    deinit {
        validator = nil
    }
    
    @Test
    func testDetectCardType() {
        #expect(validator.detectCardType(from: validAmex) == .amex)
        #expect(validator.detectCardType(from: validDiscover) == .discover)
        #expect(validator.detectCardType(from: validMasterCard) == .masterCard)
        #expect(validator.detectCardType(from: validVisa) == .visa)
        #expect(validator.detectCardType(from: "123456789") == .unknown)
    }
    
    @Test
    func testIsValidCard() {
        #expect(validator.isValidCard(validVisa))
        #expect(validator.isValidCard(validAmex))
        #expect(validator.isValidCard(validDiscover))
        #expect(validator.isValidCard(validMasterCard))
        #expect(!validator.isValidCard("123456789"))
        #expect(!validator.isValidCard(""))
        #expect(!validator.isValidCard("abcd1234"))
    }
    
    @Test
    func testDetectCardTypeWithNonNumericCharacters() {
        #expect(validator.detectCardType(from: "3782-8224-6310-005") == .amex,
                "Should detect American Express even with dashes")
        #expect(validator.detectCardType(from: "4111 1111 1111 1111") == .visa,
                "Should detect Visa even with spaces")
    }
    
    @Test
    func testIsValidCardWithNonNumericCharacters() {
        #expect(validator.isValidCard("3782-8224-6310-005"), "Should validate Amex with dashes")
        #expect(validator.isValidCard("4111 1111 1111 1111"), "Should validate Visa with spaces")
        #expect(!validator.isValidCard("5555-5555-5555-4443"), "Should invalidate incorrect MasterCard")
    }
}
