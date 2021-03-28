//
//  ContentView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        if let image = viewModel.currentImage {
            VStack {
                EditImageView(viewModel: EditImageViewModel(originalImage: image))
                if editMode?.wrappedValue == .inactive {
                    HStack {
                        Button(action: viewModel.showPrevious) {
                            Image(systemName: "chevron.backward")
                        }
                        .disabled(!viewModel.hasPrevious)
                        Button(action: viewModel.showNext) {
                            Image(systemName: "chevron.forward")
                        }
                        .disabled(!viewModel.hasNext)
                    }
                }
            }
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
