//
//  CollapsableCard.swift
//  XpehoUI
//
//  Created by Ryan Debouvries on 25/07/2024.
//

import SwiftUI

public struct CollapsableCard: View {
    var label: String
    var headTag: TagPill?
    var tags: [TagPill]
    var button: ClickyButton?
    var icon: AnyView
    var openArrowIcon: AnyView
    var closeArrowIcon: AnyView
    
    var size: Float
    
    var labelColor: Color
    var backgroundColor: Color
    
    var collapsable: Bool
    var defaultOpen: Bool
    
    var onPressButton: () -> Void
    
    @State private var open: Bool = true
    
    public init(
        label: String = "Collapsable Card",
        headTag: TagPill? = nil,
        tags: [TagPill] = [],
        button: ClickyButton? = nil,
        icon: AnyView = AnyView(
            Assets.loadImage(named: "Briefcase")
                .renderingMode(.template)
                .foregroundStyle(XPEHO_THEME.XPEHO_COLOR)
        ),
        openArrowIcon: AnyView = AnyView(
            Assets.loadImage(named: "Chevron-down")
                .renderingMode(.template)
                .foregroundStyle(XPEHO_THEME.CONTENT_COLOR)
        ),
        closeArrowIcon: AnyView = AnyView(
            Assets.loadImage(named: "Chevron-up")
                .renderingMode(.template)
                .foregroundStyle(XPEHO_THEME.CONTENT_COLOR)
        ),
        size: Float = 18.0,
        labelColor: Color = XPEHO_THEME.CONTENT_COLOR,
        backgroundColor: Color = .white,
        collapsable: Bool = true,
        defaultOpen: Bool = true,
        onPressButton: @escaping () -> Void = {
            debugPrint("The button is pressed")
        }
    ) {
        self.label = label
        self.headTag = headTag
        self.tags = tags
        self.button = button
        self.icon = icon
        self.openArrowIcon = openArrowIcon
        self.closeArrowIcon = closeArrowIcon
        self.size = size
        self.labelColor = labelColor
        self.backgroundColor = backgroundColor
        self.collapsable = collapsable
        self.defaultOpen = defaultOpen
        self.onPressButton = onPressButton
        self._open = State(initialValue: defaultOpen)
    }
    
    public var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                HStack (spacing: 12) {
                    if collapsable {
                        icon
                    }
                    Text(label)
                        .foregroundStyle(labelColor)
                        .font(.raleway(.regular, size: CGFloat(size)))
                }
                if let headTag = self.headTag {
                    Spacer()
                    headTag
                }
                Spacer()
                if collapsable {
                    (open ? closeArrowIcon : openArrowIcon)
                } else {
                    icon
                }
            }
            if open {
                VStack (spacing: 22) {
                    WrappingHStack (alignment: .leading) {
                        ForEach(tags.indices, id: \.self) { index in
                            tags[index]
                        }
                        Spacer()
                    }
                    if let button = self.button {
                        button
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.2), value: open)
        .onTapGesture {
            if collapsable {
                open.toggle()
            }
        }
    }
}

#Preview {
    CollapsableCard(
        tags: [TagPill(), TagPill(), TagPill(), TagPill()],
        button: ClickyButton()
    )
}

