//
//  ContentView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        if let image = viewModel.currentImage {
            EditImageView(viewModel: EditImageViewModel(originalImage: image))
                .gesture(DragGesture(minimumDistance: 100)
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    viewModel.showNext()
                                } else if value.translation.width > 0 {
                                    viewModel.showPrevious()
                                }
                            }
                )
                .padding()
        } else {
            Text("No image to show")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    // Added preview for both light and dark mode to remind about the need to support both of modes. Full support of dark/light modes is out of scope for test task
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { _ in
            ContentView(viewModel: ContentViewModel())
                .environment(\.editMode, Binding.constant(EditMode.active))
                .padding()
                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
