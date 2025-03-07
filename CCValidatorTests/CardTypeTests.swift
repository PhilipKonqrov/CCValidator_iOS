//
//  CardTypeTests.swift
//  CCValidatorTests
//
//  Created by Philip Plamenov on 5.03.25.
//

import Testing
@testable import CCValidator

struct CardTypeTests {
    @Test
    func testRawValues() {
        #expect(CardType.amex.rawValue == "American Express")
        #expect(CardType.discover.rawValue == "Discover")
        #expect(CardType.masterCard.rawValue == "MasterCard")
        #expect(CardType.visa.rawValue == "Visa")
        #expect(CardType.unknown.rawValue == "Unknown brand")
    }

    @Test
    func testBrandImageNames() {
        #expect(CardType.amex.brandImageName == "american-express")
        #expect(CardType.discover.brandImageName == "discover")
        #expect(CardType.masterCard.brandImageName == "mastercard")
        #expect(CardType.visa.brandImageName == "visa")
        #expect(CardType.unknown.brandImageName == nil) // Unknown should return nil
    }
}
