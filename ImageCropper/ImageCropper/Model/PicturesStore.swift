//
//  PicturesStore.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import UIKit

final class PicturesStore: ObservableObject {
    @Published var pictures: [Picture]

    init(pictures: [Picture] = [Picture(named: "Car1"), Picture(named: "Car2"), Picture(named: "Car3")]) {
        self.pictures = pictures
    }
}
