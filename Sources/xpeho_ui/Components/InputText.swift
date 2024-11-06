//
//  InputText.swift
//  XpehoUI
//
//  Created by Ryan Debouvries on 05/08/2024.
//


import SwiftUI

public struct InputText: View {
    var label: String
    var passwordSwitcherIcon: AnyView
    var defaultInput: String
    
    var labelSize: Float
    var inputSize: Float
    
    var labelColor: Color
    var backgroundColor: Color
    var inputColor: Color
    
    var password: Bool
    
    var submitLabel: SubmitLabel
    var onSubmit: () -> Void
    var onInput: (String) -> Void
    
    @State private var hidden: Bool = true
    @State private var input: String
    @FocusState private var focused: Bool

    public init (
        label: String = "Input Text",
        passwordSwitcherIcon: AnyView = AnyView(
            Assets.loadImage(named: "Eye")
                .renderingMode(.template)
                .foregroundStyle(XPEHO_THEME.CONTENT_COLOR)
        ),
        defaultInput: String = "",
        labelSize: Float = 11.0,
        inputSize: Float = 16.0,
        labelColor: Color = XPEHO_THEME.CONTENT_COLOR.opacity(0.5),
        backgroundColor: Color = .white,
        inputColor: Color = XPEHO_THEME.CONTENT_COLOR,
        password: Bool = false,
        submitLabel: SubmitLabel = .next,
        onSubmit: @escaping () -> Void = {},
        onInput: @escaping (String) -> Void = { input in
            debugPrint("The input \(input) is typed")
        }
    ) {
        self.label = label
        self.passwordSwitcherIcon = passwordSwitcherIcon
        self.defaultInput = defaultInput
        self.labelSize = labelSize
        self.inputSize = inputSize
        self.labelColor = labelColor
        self.backgroundColor = backgroundColor
        self.inputColor = inputColor
        self.password = password
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
        self.onInput = onInput
        self._input = State(initialValue: defaultInput)
    }
    
    public var body: some View {
        ZStack (alignment: .leading) {
            Text(label)
                .font(.raleway(.medium, size: CGFloat(input.isEmpty ? inputSize : labelSize)))
                .foregroundStyle(labelColor)
                .offset(y: CGFloat(input.isEmpty ? 0 : -(inputSize + 5)))
            HStack {
                if (password && hidden) {
                    SecureField(
                        "",
                        text: $input,
                        onCommit: onSubmit
                    )
                    .font(.roboto(.regular, size: CGFloat(inputSize)))
                    .focused($focused)
                    #if os(iOS)
                    .textInputAutocapitalization(.never)
                    .submitLabel(submitLabel)
                    #endif
                    .onChange(of: input) { oldValue, newValue in
                        onInput(newValue)
                    }
                    .foregroundStyle(inputColor)
                } else {
                    TextField(
                        "",
                        text: $input,
                        onCommit: onSubmit
                    )
                    .font(.roboto(.regular, size: CGFloat(inputSize)))
                    .focused($focused)
                    #if os(iOS)
                    .textInputAutocapitalization(.never)
                    .submitLabel(submitLabel)
                    #endif
                    .onChange(of: input) { oldValue, newValue in
                        onInput(newValue)
                    }
                    .foregroundStyle(inputColor)
                }
                if (!input.isEmpty && password){
                    passwordSwitcherIcon
                        .pressAction {
                            hidden = false
                        } onRelease: {
                            hidden = true
                        }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .padding(.top, CGFloat(input.isEmpty ? 12 : inputSize + 12))
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.2), value: hidden)
        .animation(.easeInOut(duration: 0.2), value: input.isEmpty)
        .accessibilityIdentifier(label)
    }
}

#Preview {
    InputText()
}
