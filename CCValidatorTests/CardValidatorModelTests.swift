//
//  CardValidatorModelTests.swift
//  CCValidatorTests
//
//  Created by mac on 5.03.25.
//

import Testing
@testable import CCValidator

class CardValidatorModelTests {
    var viewModel: CardValidatorModel!
    let validVisa = "4111111111111111"
    let validMasterCard = "5105105105105100"
    let validDiscover = "6011111111111117"
    let validAmex = "378282246310005"

    init() {
        viewModel = CardValidatorModel()
    }

    deinit {
        viewModel = nil
    }

    @Test
    func testDetectCardType() {
        #expect(viewModel.detectCardType(from: validAmex) == .amex)
        #expect(viewModel.detectCardType(from: validDiscover) == .discover)
        #expect(viewModel.detectCardType(from: validMasterCard) == .masterCard)
        #expect(viewModel.detectCardType(from: validVisa) == .visa)
        #expect(viewModel.detectCardType(from: "123456789") == .unknown)
    }

    @Test
    func testIsValidCard() {
        #expect(viewModel.isValidCard(validVisa))
        #expect(viewModel.isValidCard(validAmex))
        #expect(viewModel.isValidCard(validDiscover))
        #expect(viewModel.isValidCard(validMasterCard))
        #expect(!viewModel.isValidCard("123456789"))
        #expect(!viewModel.isValidCard(""))
        #expect(!viewModel.isValidCard("abcd1234"))
    }

    @Test
    func testBrandImageName() {
        viewModel.cardNumber = validAmex
        #expect(viewModel.brandImageName == "american-express")

        viewModel.cardNumber = validDiscover
        #expect(viewModel.brandImageName == "discover")

        viewModel.cardNumber = validMasterCard
        #expect(viewModel.brandImageName == "mastercard")

        viewModel.cardNumber = validVisa
        #expect(viewModel.brandImageName == "visa")

        viewModel.cardNumber = "123456789"
        #expect(viewModel.brandImageName == nil)
    }

    @Test
    func testIsValidProperty() {
        viewModel.cardNumber = validVisa
        #expect(viewModel.isValid)

        viewModel.cardNumber = "123456789"
        #expect(!viewModel.isValid)

        viewModel.cardNumber = validAmex
        #expect(viewModel.isValid)

        viewModel.cardNumber = validDiscover
        #expect(viewModel.isValid)

        viewModel.cardNumber = validMasterCard
        #expect(viewModel.isValid)
    }
}

