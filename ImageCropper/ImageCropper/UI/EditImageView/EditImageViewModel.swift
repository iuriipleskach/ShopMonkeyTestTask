//
//  EditImageViewModel.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 28.03.2021.
//

import UIKit
import CoreGraphics

class EditImageViewModel: ObservableObject {
    private var originalImage: UIImage

    @Published var image: UIImage
    @Published var scale: CGFloat = 1

    // MARK: - Init
    internal init(originalImage: UIImage) {
        self.originalImage = originalImage
        image = originalImage
    }

    // MARK: - Image Editing

    // rect - cropped rectangle in view coordinates
    // geomemetrySize - the size of the view
    func crop(rect: CGRect, within geomemetrySize: CGSize) {
        let scaleTransform = CGAffineTransform(
            scaleX: image.size.width / geomemetrySize.width,
            y: image.size.height / geomemetrySize.height
        )
        let imageCropRect = rect
            .applying(scaleTransform)

        image = image.cropping(to: imageCropRect) ?? UIImage()
    }

    func scale(_ scaleFactor: CGFloat) {
        scale = scaleFactor
    }

    // MARK: -

    func applyEdits() {
        guard scale > 1.0 else { return }
        let imageRect = CGRect(origin: .zero, size: image.size)
        let invertedScale = 1.0 / scale
        let scaleTransform = CGAffineTransform.identity
            .translatedBy(x: imageRect.midX, y: imageRect.midY)
            .scaledBy(x: invertedScale, y: invertedScale)
            .translatedBy(x: -imageRect.midX, y: -imageRect.midY)
        let cropRect = imageRect
            .applying(scaleTransform)
            .integral

        image = image.cropping(to: cropRect) ?? UIImage()
        scale = 1
        originalImage = image
    }

    func reset() {
        image = originalImage
        scale = 1
    }
}
