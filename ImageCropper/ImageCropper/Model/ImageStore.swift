//
//  ImageStore.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

class ImageStore: ObservableObject {
    @Published var images: [Image]

    init(images: [Image] = [Image("Car1"), Image("Car2"), Image("Car3")]) {
        self.images = images
    }
}
