//
//  DefaultCardValidator.swift
//  CCValidator
//
//  Created by mac on 5.03.25.
//

import Foundation

protocol CardValidatorRepresentable: ObservableObject {
    func detectCardType(from number: String) -> CardType
    func isValidCard(_ number: String) -> Bool
}

class DefaultCardValidator: CardValidatorRepresentable {
    /// Detects the brand of the card based on the provided string of numbers.
    /// Currently supported types are American Express, Visa, Mastercard and Discover.
    func detectCardType(from number: String) -> CardType {
        let sanitizedNumber = number.filter { $0.isNumber }

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
        guard !number.isEmpty else { return false }
        let digits = number.filter(\.isNumber).compactMap(\.wholeNumberValue).reversed()

        let totalSum = digits.enumerated().reduce(into: 0) { sum, pair in
            let (index, digit) = pair
            if index.isMultiple(of: 2) {
                sum += digit
            } else {
                let doubled = digit * 2
                sum += doubled > 9 ? doubled - 9 : doubled
            }
        }

        return totalSum.isMultiple(of: 10)
    }
}
