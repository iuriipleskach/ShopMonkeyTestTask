//
//  EditableImage.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import UIKit

class EditableImage: ObservableObject, Identifiable {
    private var originalImage: UIImage {
        didSet {
            uiImage = originalImage
        }
    }

    let id = UUID()
    @Published var uiImage: UIImage

    #warning("or init with UIImage already + implement ImageLoader")
    internal init(imageName: String) {
        #warning("throw error instead?")
        let image = UIImage(named: imageName) ?? UIImage()
        originalImage = image
        uiImage = image
    }

    // MARK: -

    #warning("implement generic method like applyEdits()")
    func crop(to rect: CGRect) {
        uiImage = uiImage.cropping(to: rect) ?? UIImage()
    }

    func commit() {
        #warning("save to disk")
    }

    func reset() {
        uiImage = originalImage
    }
}

extension EditableImage {
    // Returns the maximum size that is bounded by the specified size and preserving aspect ratio
    func boundingSize(with size: CGSize) -> CGSize {
        let width = uiImage.size.width
        let height = uiImage.size.height
        let scale: CGFloat
        if width > height {
            scale = size.width / width
        } else {
            scale = size.height / height
        }

        let size = CGSize(width: round(width * scale), height: round(height * scale))
        return size
    }
}
