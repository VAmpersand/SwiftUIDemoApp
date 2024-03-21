//
//  DATextField.swift
//  SwiftUIDemoApp
//
//  Created by Viktor Prikolota on 19.03.2024.
//

import SwiftUI

extension DATextField {
    enum InputType {
        case singleline
        case multiline
        case singlelineSecure
    }

    enum InputState: Equatable {
        case regular(message: String?)
        case success(message: String?)
        case error(message: String?)

        var message: String? {
            switch self {
            case .regular(let message), .success(let message), .error(let message):
                return message
            }
        }
    }

    struct Configuration {
        let titleColor: Color
        let borderColor: Color
        let hintColor: Color
    }

    enum FieldState {
        case empty
        case highlighted
        case fill
        case error
        case errorHighlighted

        var config: Configuration {
            switch self {
            case .empty, .fill:
                return Configuration(titleColor: DAColor.contentTertiary,
                                     borderColor: DAColor.borderRegular,
                                     hintColor: DAColor.contentSecondary)
            case .highlighted:
                return Configuration(titleColor: DAColor.contentAccent,
                                     borderColor: DAColor.contentAccent,
                                     hintColor: DAColor.contentSecondary)
            case .error, .errorHighlighted:
                return Configuration(titleColor: DAColor.contentWarning,
                                     borderColor: DAColor.contentWarning,
                                     hintColor: DAColor.contentWarning)
            }
        }

        var shouldChangeLayout: Bool {
            [.highlighted, .fill, .error, .errorHighlighted].contains(self)
        }

        mutating func setHighlighting(_ isHighlighted: Bool, textIsEmpty: Bool) {
            switch self {
            case .empty, .fill: self = isHighlighted ? .highlighted : (textIsEmpty ? .empty : .fill)
            case .error, .errorHighlighted: self = isHighlighted ? .errorHighlighted : .error
            case .highlighted: self = textIsEmpty ? .empty : .fill
            }
        }

        mutating func setInputState(_ inputState: InputState, textIsEmpty: Bool) {
            let isHighlighted = [.highlighted, .errorHighlighted].contains(self)
            switch inputState {
            case .regular, .success:
                self = isHighlighted ? .highlighted : (textIsEmpty ? .empty : .fill)
            case .error:
                self = isHighlighted ? .errorHighlighted : .error
            }
        }
    }
}

struct DATextField: View {

    private let title: String
    @Binding private var text: String
    @Binding private var inputState: InputState

    @FocusState private var isTextFieldFocused: Bool
    @State private var state = FieldState.empty
    @State private var footerText = ""
    @State private var footerIsHidden = true

    init(title: String, text: Binding<String>, state: Binding<InputState>) {
        self.title = title
        self._text = text
        self._inputState = state
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(DAFont.title03)
                .offset(y: state.shouldChangeLayout ? 13 : 25)
                .scaleEffect(state.shouldChangeLayout ? 0.5 : 1, anchor: .leading)
                .foregroundStyle(state.config.titleColor)

            TextField("", text: $text)
                .focused($isTextFieldFocused)
                .onChange(of: isTextFieldFocused) { [self] isFocused in
                    withAnimation(.easeInOut(duration: 0.15)) {
                        state.setHighlighting(isFocused, textIsEmpty: text.isEmpty)
                    }
                }

            Capsule(style: .continuous)
                .foregroundColor(state.config.borderColor)
                .frame(height: 2)
                .padding(.top, 5)

            if !footerIsHidden {
                Text(footerText)
                    .foregroundStyle(state.config.hintColor)
                    .font(DAFont.caption02)
            }
        }
        .onChange(of: inputState) { [self] newInputState in
            withAnimation(.easeInOut(duration: 0.15)) {
                if let message = self.inputState.message { self.footerText = message }
                self.footerIsHidden = (newInputState.message?.isEmpty ?? true)

                state.setInputState(newInputState, textIsEmpty: text.isEmpty)
            }
        }
    }
}
