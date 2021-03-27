//
//  CropOverlayView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct CropOverlayView: View {
    @State var isDragging = false
    @State var dragInsets = EdgeInsets()

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(isDragging ? Color.blue.opacity(0.15) : Color.clear)
                .border(Color.black, width: 3)
                .padding(dragInsets)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            isDragging = true
                            updateDragInsets(for: value, geometry: geometry)
                        }
                        .onEnded { value in
                            isDragging = false
                            resetDragInsets()
                        }
                )
        }
    }

    // MARK: -

    private func updateDragInsets(for value: DragGesture.Value, geometry: GeometryProxy) {
        let width = geometry.size.width
        let height = geometry.size.height
        let startLocation = value.startLocation
        let translation = value.translation
        let borderDragableWidth: CGFloat = 20 // AHIG minimum tapable area (40) divided by 2

        var insets = EdgeInsets()
        if abs(startLocation.x) < borderDragableWidth {
            insets.leading += translation.width
        } else if abs(startLocation.y) < borderDragableWidth {
            insets.top += translation.height
        } else if abs(width - startLocation.x) < borderDragableWidth {
            insets.trailing -= translation.width
        } else if abs(height - startLocation.y) < borderDragableWidth {
            insets.bottom -= translation.height
        }

        dragInsets = insets
    }

    private func resetDragInsets() {
        dragInsets = EdgeInsets()
    }
}

struct CropOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        CropOverlayView()
            .padding()
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
