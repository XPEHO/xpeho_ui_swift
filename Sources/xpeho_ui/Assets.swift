//
//  Assets.swift
//
//
//  Created by Ryan Debouvries on 07/08/2024.
//

import SwiftUI

public struct Assets {
    
    // Usage : Assets.loadImage(named: "ImageName")

    #if canImport(UIKit)
    public static func loadImage(named name: String) -> Image {
        let uiImage = UIImage(named: name, in: Bundle.module, compatibleWith: nil)
        return Assets.convertUIImageToImage(uiImage: uiImage)
    }
    
    public static func convertUIImageToImage(uiImage: UIImage?) -> Image {
        var imageConverted: Image {
            if let uiImage {
                return Image(uiImage: uiImage)
            } else {
                return Image(systemName: "xmark.circle") // Image de remplacement en cas d'échec du chargement
            }
        }
        return imageConverted
    }

    #elseif canImport(AppKit)
    public static func loadImage(named name: String) -> Image {
        let nsImage = NSImage(named: NSImage.Name(name))
        return Assets.convertNSImageToImage(nsImage: nsImage)
    }
    
    public static func convertNSImageToImage(nsImage: NSImage?) -> Image {
        var imageConverted: Image {
            if let nsImage {
                return Image(nsImage: nsImage)
            } else {
                return Image(systemName: "xmark.circle") // Image de remplacement en cas d'échec du chargement
            }
        }
        return imageConverted
    }

    #endif
}
