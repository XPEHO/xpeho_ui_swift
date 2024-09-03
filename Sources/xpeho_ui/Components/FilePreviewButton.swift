//
//  FilePreviewButton.swift
//  XpehoUI
//
//  Created by Ryan Debouvries on 22/07/2024.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public struct FilePreviewButton: View {
    
    var labelStart: String
    var labelEnd: String
    var imagePreview: AnyView
    var tags: [TagPill]
    var arrowIcon: AnyView
    
    var height: Float
    var labelSize: Float
    
    var backgroundColor: Color
    var labelColor: Color
    
    var enabled: Bool
    var labelPosition: LabelPosition
    
    var onPress: () -> Void
    
    @State private var pressed = false

    public init (
        labelStart: String = "FileName",
        labelEnd: String = "FileInfo",
        imagePreview: AnyView = AnyView(
            Assets.loadImage(named: "Placeholder")
                .resizable()
        ),
        tags: [TagPill] = [],
        arrowIcon: AnyView = AnyView(
            Assets.loadImage(named: "Arrow-right")
                .renderingMode(.template)
                .foregroundStyle(.white)
        ),
        height: Float = 232,
        labelSize: Float = 18,
        backgroundColor: Color = .white,
        labelColor: Color = XPEHO_THEME.CONTENT_COLOR,
        enabled: Bool = true,
        labelPosition: LabelPosition = .top,
        onPress: @escaping () -> Void = {
            debugPrint("The button is pressed")
        }
    ) {
        self.labelStart = labelStart
        self.labelEnd = labelEnd
        self.imagePreview = imagePreview
        self.tags = tags
        self.arrowIcon = arrowIcon
        self.height = height
        self.labelSize = labelSize
        self.backgroundColor = backgroundColor
        self.labelColor = labelColor
        self.enabled = enabled
        self.labelPosition = labelPosition
        self.onPress = onPress
    }
    
    public enum LabelPosition {
        case top, bottom
    }
    
    public var body: some View {
        Button(action: onPress) {
            VStack (spacing: 0) {
                if labelPosition == .top {
                    HStack() {
                        Text(labelStart)
                        Spacer()
                        Text(labelEnd)
                    }
                    .padding(12)
                    .foregroundStyle(labelColor)
                    .font(.raleway(.regular, size: CGFloat(labelSize)))
                    .background(backgroundColor)
                }
                VStack {
                    Spacer()
                    HStack (alignment: .bottom){
                        GeometryReader { geometry in
                            VStack {
                                Spacer()
                                HStack (alignment: .bottom) {
                                    ForEach(tags.indices, id: \.self) { index in
                                        tags[index]
                                        .fixedSize(horizontal: true, vertical: false)
                                    }
                                }
                                .frame(width: geometry.size.width, alignment: .leading)
                                .clipShape(Rectangle())
                            }
                        }
                        Spacer()
                        arrowIcon
                            .padding(.leading, 5)
                            .offset(x: pressed ? 40 : 0)
                            .opacity(pressed ? 0 : 1)
                            .animation(.easeInOut(duration: 0.2), value: pressed)
                    }
                    .padding()
                }
                .frame(height: CGFloat(height))
                .background(
                    ZStack {
                        imagePreview
                            .scaledToFill()

                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: XPEHO_THEME.CONTENT_COLOR.opacity(0), location: 0.7),
                            .init(color: XPEHO_THEME.CONTENT_COLOR.opacity(1), location: 1)]),
                            startPoint: .top,
                            endPoint: .bottom)
                    }
                )
                .clipped()
                if labelPosition == .bottom {
                    HStack() {
                        Text(labelStart)
                        Spacer()
                        Text(labelEnd)
                    }
                    .padding(12)
                    .foregroundStyle(labelColor)
                    .font(.raleway(.regular, size: CGFloat(labelSize)))
                    .background(backgroundColor)
                }
            }
            .background(backgroundColor)
        }
        .grayscale(enabled ? 0 : 1)
        .background(backgroundColor)
        .buttonStyle(NoTapAnimationStyle())
        .pressAction {
            pressed = true
        } onRelease: {
            pressed = false
        }
        .disabled(!enabled)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .accessibilityIdentifier(labelStart)
    }
}

#Preview {
    FilePreviewButton(
        tags: [
            TagPill(),
            TagPill(),
            TagPill(),
            TagPill(),
            TagPill(),
            TagPill(),
            TagPill()
        ]
    )
}

