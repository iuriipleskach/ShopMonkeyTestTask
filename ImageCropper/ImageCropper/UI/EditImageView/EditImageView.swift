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
    @ObservedObject var viewModel: EditImageViewModel

    var body: some View {
        ZStack {
            VStack {
                EditToolbar(cancel: viewModel.reset, save: viewModel.applyEdits, reset: viewModel.reset)
                    .zIndex(1.0)
                Spacer(minLength: spacerMinLength)

                HStack {
                    Spacer(minLength: spacerMinLength)
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(viewModel.scale)
                        .overlay(
                            GeometryReader { overlayGeometry in
                                CropOverlayView { overlayCropRect in
                                    viewModel.crop(rect: overlayCropRect, within: overlayGeometry.size)
                                }
                            }
                        )
                        .gesture(
                            MagnificationGesture()
                                    .onChanged { value in
                                        withAnimation {
                                            viewModel.scale(value)
                                        }
                                    }
                                    .onEnded { value in
                                        withAnimation {
                                            viewModel.scale(max(1, value))
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
        EditImageView(viewModel: EditImageViewModel(originalImage: ImageStore().images[2]))
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
