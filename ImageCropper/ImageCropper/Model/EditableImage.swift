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
        originalImage = uiImage
    }

    func reset() {
        uiImage = originalImage
    }
}
