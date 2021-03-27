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
    static var previews: some View {
        ContentView(imageStore: ImageStore())
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
