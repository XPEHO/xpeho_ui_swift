//
//  TagPill.swift
//  XpehoUI
//
//  Created by Ryan Debouvries on 22/07/2024.
//

import SwiftUI

public struct TagPill: View {
    var label: String
    
    var size: Float
    
    var backgroundColor: Color
    var labelColor: Color
    
    var icon: AnyView?
    
    public init(
        label: String = "Tag Pill",
        size: Float = 10.0,
        backgroundColor: Color = XPEHO_THEME.XPEHO_COLOR,
        labelColor: Color = .white,
        icon: AnyView? = nil
    ) {
        self.label = label
        self.size = size
        self.backgroundColor = backgroundColor
        self.labelColor = labelColor
        self.icon = icon
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            if let icon = icon {
                icon
                    .frame(width: CGFloat(size), height: CGFloat(size))
                    .foregroundColor(labelColor)
            }
            Text(label)
                .font(.rubik(.semiBold, size: CGFloat(size)))
                .textCase(.uppercase)
                .lineLimit(1)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
        .background(backgroundColor)
        .foregroundColor(labelColor)
        .cornerRadius(6)
    }
}

#Preview {
    TagPill(
        label: "Tag Pill Customized",
        backgroundColor: XPEHO_THEME.XPEHO_COLOR,
        labelColor: .white
    )
    
    TagPill(
        label: "Tag Pill Customized for icon",
        backgroundColor: XPEHO_THEME.XPEHO_COLOR,
        labelColor: .white,
        icon: AnyView(Image(systemName: "location.circle")
            .resizable()
            .scaledToFit()
            .foregroundColor(.white))
    )
}
