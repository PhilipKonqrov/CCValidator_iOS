//
//  CardViewModel.swift
//  CCValidator
//
//  Created by mac on 6.03.25.
//

import Foundation

enum CardType: String {
    case amex = "American Express"
    case discover = "Discover"
    case masterCard = "MasterCard"
    case visa = "Visa"
    case unknown = "Unknown brand"
}

protocol CardValidatorRepresentable: ObservableObject {
    var cardNumber: String { get set }
    var cardType: CardType { get }
    var isValid: Bool { get }
    var brandImageName: String? { get }
    
    func detectCardType(from number: String) -> CardType
    func isValidCard(_ number: String) -> Bool
}

class CardValidatorModel: ObservableObject, CardValidatorRepresentable {
    @Published var cardNumber: String = ""
    
    var cardType: CardType { detectCardType(from: cardNumber) }
    var isValid: Bool { isValidCard(cardNumber) && cardType != .unknown }
    var brandImageName: String? {
        switch cardType {
        case .amex: return "american-express"
        case .discover: return "discover"
        case .masterCard: return "mastercard"
        case .visa: return "visa"
        case .unknown: return nil
        }
    }
    
    /// Detects the brand of the card based on the provided string of numbers.
    /// Currently supported types are American Express, Visa, Mastercard and Discover.
    func detectCardType(from number: String) -> CardType {
        guard isValidCard(number) else { return .unknown }
        
        let sanitizedNumber = number.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)

        if sanitizedNumber.starts(with: "34") || sanitizedNumber.starts(with: "37"), sanitizedNumber.count == 15 {
            return .amex
        } else if sanitizedNumber.starts(with: "6011"), sanitizedNumber.count == 16 {
            return .discover
        } else if let prefix = Int(sanitizedNumber.prefix(2)), (51...55).contains(prefix), sanitizedNumber.count == 16 {
            return .masterCard
        } else if sanitizedNumber.starts(with: "4"), [13, 16].contains(sanitizedNumber.count) {
            return .visa
        }
        return .unknown
    }

    /// Detects if the provided card number is valid using the Luhn validity algorithm.
    func isValidCard(_ number: String) -> Bool {
        let cleanedNumber = number.filter { $0.isNumber }
        if cleanedNumber.isEmpty { return false }
        
        let digits = cleanedNumber.reversed().compactMap { $0.wholeNumberValue }
        var totalSum = 0

        for (index, digit) in digits.enumerated() {
            if index % 2 == 1 {
                let doubled = digit * 2
                totalSum += (doubled > 9) ? (doubled - 9) : doubled
            } else {
                totalSum += digit
            }
        }
        
        return totalSum % 10 == 0
    }
}
