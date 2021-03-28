//
//  ImageStore.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import UIKit

final class ImageStore: ObservableObject {
    @Published var images: [UIImage]

    init(images: [UIImage] = [UIImage(named: "Car1")!, UIImage(named: "Car2")!, UIImage(named: "Car3")!]) { // Force unwrap is used only for testing purposes to simplify the initialization code
        self.images = images
    }
}
