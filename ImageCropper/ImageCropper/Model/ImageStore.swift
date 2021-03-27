//
//  ImageStore.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

final class ImageStore: ObservableObject {
    @Published var images: [EditableImage]

    init(images: [EditableImage] = [EditableImage(imageName: "Car1"), EditableImage(imageName: "Car2"), EditableImage(imageName: "Car3")]) { // Force unwrap is used only for testing purposes to simplify the initialization code
        self.images = images
    }
}
