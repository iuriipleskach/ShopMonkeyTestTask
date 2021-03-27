//
//  CropOverlayView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct CropOverlayView: View {
    private var editModeEnabled: Bool {
        editMode?.wrappedValue == .active
    }
    private var borderWidth: CGFloat {
        editModeEnabled ? 3 : 0
    }
    let onCropChanged: ((CGRect) -> Void)

    @Environment(\.editMode) var editMode
    @State private var isDragging = false
    @State private var dragInsets = EdgeInsets()

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(isDragging ? Color.blue.opacity(0.15) : Color.clear)
                .border(Color.black, width: borderWidth)
                .padding(dragInsets)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            dragGestureUpdated(with: value, geometry: geometry)
                        }
                        .onEnded { value in
                            dragGestureFinished(with: value, geometry: geometry)
                        }
                )
        }
    }

    // MARK: -

    private func calculateDragInsets(for value: DragGesture.Value, geometry: GeometryProxy) -> EdgeInsets {
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

        // TODO: validate insets
        return insets
    }

    private func dragGestureUpdated(with value: DragGesture.Value, geometry: GeometryProxy) {
        if editModeEnabled {
            isDragging = true
            dragInsets = calculateDragInsets(for: value, geometry: geometry)
        }
    }

    private func dragGestureFinished(with value: DragGesture.Value, geometry: GeometryProxy) {
        if editModeEnabled {
            let insets = calculateDragInsets(for: value, geometry: geometry)
            let originalFrame = CGRect(origin: .zero, size: geometry.size)
            let croppedFrame = originalFrame.inset(by: insets.uiEdgeInsets)
            onCropChanged(croppedFrame)

            isDragging = false
            dragInsets = EdgeInsets() // Reset insets
        }
    }
}

struct CropOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        CropOverlayView(onCropChanged: { _ in })
            .padding()
            .previewDevice("iPad Pro (9.7-inch)")
    }
}

// MARK: -

private extension EdgeInsets {
    var uiEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
    }
}
