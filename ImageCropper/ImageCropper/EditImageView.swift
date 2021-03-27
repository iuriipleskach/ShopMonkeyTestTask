//
//  EditImageView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct EditImageView: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                CropOverlayView()
            )
            .padding()
    }
}

struct EditImageView_Previews: PreviewProvider {
    static var previews: some View {
        EditImageView(image: ImageStore().images[0])
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
