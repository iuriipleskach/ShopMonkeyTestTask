//
//  Picture.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 28.03.2021.
//

import UIKit

class Picture {
    var image: UIImage
    var size: CGSize {
        image.size
    }

    internal init(named name: String) {
        image = UIImage(named: name) ?? UIImage()
    }
}
