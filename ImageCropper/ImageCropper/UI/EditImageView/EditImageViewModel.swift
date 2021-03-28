//
//  EditImageViewModel.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 28.03.2021.
//

import UIKit
import CoreGraphics

class EditImageViewModel: ObservableObject {
    private var originalPicture: Picture

    @Published var image: UIImage
    @Published var scale: CGFloat = 1

    // MARK: - Init
    internal init(originalImage: Picture) {
        self.originalPicture = originalImage
        image = originalImage.image
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
        if scale > 1.0 { // then apply crop corresponding to scale
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
        }

        scale = 1
        originalPicture.image = image
    }

    func undo() {
        image = originalPicture.image
        scale = 1
    }
}
