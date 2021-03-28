//
//  ContentView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var imageStore: ImageStore
    var body: some View {
        EditImageView(image: imageStore.images[0])
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    // Added preview for both light and dark mode to remind about the need to support both of modes. Full support of dark/light modes is out of scope for test task
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { _ in
            ContentView(imageStore: ImageStore())
                .environment(\.editMode, Binding.constant(EditMode.active))
                .padding()
                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
