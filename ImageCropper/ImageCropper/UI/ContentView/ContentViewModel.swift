//
//  ContentViewModel.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 28.03.2021.
//

import UIKit

class ContentViewModel: ObservableObject {
    private let picturesStore: PicturesStore
    private var currentIndex: Int = 0 {
        didSet {
            currentImage = picturesStore.pictures[currentIndex]
        }
    }
    @Published var currentImage: Picture? = nil

    // MARK -
    internal init(picturesStore: PicturesStore = PicturesStore()) {
        self.picturesStore = picturesStore
        if currentIndex < picturesStore.pictures.count {
            currentImage = picturesStore.pictures[currentIndex]
        }
    }

    // MARK -

    var hasNext: Bool {
        currentIndex + 1 < picturesStore.pictures.count
    }

    var hasPrevious: Bool {
        currentIndex - 1 >= 0
    }

    func showPrevious() {
        let previosIndex = currentIndex - 1
        if previosIndex >= 0 {
            currentIndex = previosIndex
        }
    }

    func showNext() {
        let nextIndex = currentIndex + 1
        if nextIndex < picturesStore.pictures.count {
            currentIndex = nextIndex
        }
    }
}
