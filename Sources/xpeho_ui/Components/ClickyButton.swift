//
//  ClickyButton.swift
//  XpehoUI
//
//  Created by Ryan Debouvries on 18/07/2024.
//

import SwiftUI

public struct ClickyButton: View {
    var label: String
    
    var size: Float
    var horizontalPadding: Float
    var verticalPadding: Float
    
    var backgroundColor: Color
    var labelColor: Color
    
    var enabled: Bool
    
    var onPress: () -> Void
    
    @State private var pressed = false

    public init(
        label: String = "Clicky Button",
        size: Float = 16,
        horizontalPadding: Float = 32,
        verticalPadding: Float = 16,
        backgroundColor: Color = XPEHO_THEME.XPEHO_COLOR,
        labelColor: Color = .white,
        enabled: Bool = true,
        onPress: @escaping () -> Void = {
            debugPrint("The button is pressed")
        }
    ) {
        self.label = label
        self.size = size
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.backgroundColor = backgroundColor
        self.labelColor = labelColor
        self.enabled = enabled
        self.onPress = onPress
    }
    
    public var body: some View {
        Button(action: onPress) {
            Text(label)
                .font(.rubik(.semiBold, size: CGFloat(size)))
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, CGFloat(horizontalPadding))
        .padding(.vertical, CGFloat(verticalPadding))
        .background(enabled
                    ? backgroundColor
                    : XPEHO_THEME.DISABLED_COLOR)
        .foregroundStyle(enabled 
                         ? labelColor
                         : Color.black.opacity(0.15))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.black.opacity(0.15), lineWidth: 4)
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(enabled
                      ? backgroundColor
                      : XPEHO_THEME.DISABLED_COLOR)
                .fill(Color.black.opacity(0.15))
                .offset(y: pressed || !enabled ? 0 : 4)
        )
        .offset(y: pressed || !enabled ? 4 : 0)
        .buttonStyle(NoTapAnimationStyle())
        .pressAction {
            pressed = true
        } onRelease: {
            pressed = false
        }
        .disabled(!enabled)
        .accessibilityIdentifier(label)
    }
}

#Preview {
    ClickyButton(
        label: "Preview Button",
        size: 16,
        horizontalPadding: 32,
        verticalPadding: 16,
        backgroundColor: XPEHO_THEME.XPEHO_COLOR,
        labelColor: .white,
        enabled: true,
        onPress: {
            debugPrint("The button preview is pressed")
        }
    )
}
