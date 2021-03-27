//
//  EditImageView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct EditImageView: View {
    private let spacerMinLength: CGFloat = 40
    private let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
    @ObservedObject var image: EditableImage

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: spacerMinLength)
                HStack {
                    Spacer(minLength: spacerMinLength)
                        .foregroundColor(.blue)
                    Image(uiImage: image.uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: image.boundingSize(with: geometry.size.applying(scale)).width,
                            height: image.boundingSize(with: geometry.size.applying(scale)).height)
                        .overlay(
                            GeometryReader { geometry in
                                CropOverlayView { geometryCropRect in
                                    let scaleTransform = CGAffineTransform.init(
                                        scaleX: image.uiImage.size.width / geometry.size.width,
                                        y: image.uiImage.size.height / geometry.size.height)

                                    let geometryCropRect = geometryCropRect
                                    let imageCropRect = geometryCropRect.applying(scaleTransform)
                                    image.crop(to: imageCropRect)
                                }
                            }
                        )
                    Spacer(minLength: spacerMinLength)
                }
                Spacer(minLength: spacerMinLength)
            }
        }
    }
}

struct EditImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditImageView(image: ImageStore().images[0])
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
