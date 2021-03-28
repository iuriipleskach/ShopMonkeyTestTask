//
//  ImageCropperApp.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

@main
struct ImageCropperApp: App {
    @StateObject private var imageStore = ImageStore()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
