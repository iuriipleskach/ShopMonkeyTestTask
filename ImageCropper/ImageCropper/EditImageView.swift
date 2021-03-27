//
//  EditImageView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct EditImageView: View {
    private let spacerMinLength: CGFloat = 40

    @Environment(\.editMode) var editMode
    @ObservedObject var image: EditableImage

    var body: some View {
        VStack {
            EditToolbar(cancel: cancel, save: save)
            Spacer(minLength: spacerMinLength)

            HStack {
                Spacer(minLength: spacerMinLength)
                Image(uiImage: image.uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        GeometryReader { overlayGeometry in
                            CropOverlayView { overlayCropRect in
                                let scaleTransform = CGAffineTransform(
                                    scaleX: image.uiImage.size.width / overlayGeometry.size.width,
                                    y: image.uiImage.size.height / overlayGeometry.size.height
                                )
                                let imageCropRect = overlayCropRect.applying(scaleTransform)
                                image.crop(to: imageCropRect)
                            }
                        }
                    )
                Spacer(minLength: spacerMinLength)
            }
            Spacer(minLength: spacerMinLength)
        }
    }

    // MARK: -

    private func cancel() {
        image.reset()
    }

    private func save() {
        image.commit()
    }
}

struct EditImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditImageView(image: ImageStore().images[0])
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
