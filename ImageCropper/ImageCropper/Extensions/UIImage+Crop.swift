//
//  UIImage+Crop.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import UIKit

extension UIImage {
    func cropping(to rect: CGRect) -> UIImage? {
        guard let croppedCGImage = cgImage?.cropping(to: rect) else { return nil }
        let croppedImage = UIImage(cgImage: croppedCGImage)
        return croppedImage
    }
}
