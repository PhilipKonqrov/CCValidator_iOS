//
//  CardInputView.swift
//  CCValidator
//
//  Created by mac on 5.03.25.
//

import SwiftUI

struct CardInputView<ViewModel: CardValidatorRepresentable>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Theme.Colors.backgroundColor
            VStack(spacing: 20) {
                cardInputField
                cardValidationView
            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Theme.Colors.textColor, lineWidth: 2)
            )
            .background(
                viewModel.isValid ? Theme.Gradients.validGradient.value : Theme.Gradients.invalidGradient.value
            )
            .shadow(radius: 10)
            .padding()
        }
        .ignoresSafeArea()
        
    }
    
    var cardInputField: some View {
        TextField(Theme.Strings.enterCardNumber, text: $viewModel.cardNumber)
            .keyboardType(.numberPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: viewModel.cardNumber) { oldValue, newValue in
                viewModel.cardNumber = newValue.filter { $0.isNumber }
            }
    }
    
    var cardValidationView: some View {
        VStack {
            HStack {
                Spacer()
                if let image = viewModel.brandImageName {
                    Image(image)
                        .resizable()
                        .frame(width: 50, height: 30)
                        .padding([.horizontal, .bottom])
                } else {
                    Spacer()
                        .frame(width: 50, height: 30)
                        .padding([.horizontal, .bottom])
                }
            }
            HStack {
                Text(viewModel.cardType.rawValue)
                    .font(.headline)
                    .foregroundColor(Theme.Colors.textColor)
                Spacer()
                Group {
                    Image(systemName: viewModel.isValid ? Theme.Symbols.checkmark : Theme.Symbols.xCircle)
                    Text(viewModel.isValid ? Theme.Strings.valid : Theme.Strings.invalid)
                        .font(.headline)
                }
                .foregroundColor(Theme.Colors.textColor)
            }
            .padding([.horizontal, .bottom])
        }
    }
}
