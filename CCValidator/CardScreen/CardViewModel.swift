//
//  CardViewModel.swift
//  CCValidator
//
//  Created by mac on 5.03.25.
//

import Foundation

enum CardType: String {
    case amex = "American Express"
    case discover = "Discover"
    case masterCard = "MasterCard"
    case visa = "Visa"
    case unknown = "Unknown brand"
    
    var brandImageName: String? {
        switch self {
        case .amex: return "american-express"
        case .discover: return "discover"
        case .masterCard: return "mastercard"
        case .visa: return "visa"
        case .unknown: return nil
        }
    }
}

protocol CardViewModelRepresentable: ObservableObject {
    var cardNumber: String { get set }
    var cardType: CardType { get }
    var isValid: Bool { get }
    var validator: any CardValidatorRepresentable { get }
    
    func limitUserInput(value: String)
}

class CardViewModel: ObservableObject, CardViewModelRepresentable {
    let validator: any CardValidatorRepresentable
    var cardType: CardType { validator.detectCardType(from: cardNumber) }
    var isValid: Bool { validator.isValidCard(cardNumber) && cardType != .unknown }
    
    @Published var cardNumber: String = ""
        
    init(validator: any CardValidatorRepresentable = DefaultCardValidator()) {
        self.validator = validator
    }
    
    func limitUserInput(value: String) {
        let num = value.filter { $0.isNumber }
        cardNumber = String(num.prefix(20))
    }
}
