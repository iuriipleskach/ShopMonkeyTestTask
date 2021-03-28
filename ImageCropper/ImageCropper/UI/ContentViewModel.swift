//
//  ContentViewModel.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 28.03.2021.
//

import UIKit

class ContentViewModel: ObservableObject {
    private let imageStore: ImageStore
    private var currentIndex = 0 {
        didSet {
            currentImage = imageStore.images[currentIndex]
        }
    }
    @Published var currentImage: UIImage? = nil

    // MARK -
    internal init(imageStore: ImageStore = ImageStore()) {
        self.imageStore = imageStore
        if currentIndex < imageStore.images.count {
            currentImage = imageStore.images[currentIndex]
        }
    }

    // MARK -

    func showPrevious() {
        let previosIndex = currentIndex - 1
        if previosIndex >= 0 {
            currentIndex = previosIndex
        }
    }

    func showNext() {
        let nextIndex = currentIndex + 1
        if nextIndex < imageStore.images.count {
            currentIndex = nextIndex
        }
    }
}
