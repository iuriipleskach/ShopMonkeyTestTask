//
//  CropOverlayView.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct CropOverlayView: View {
    private let fillColor = Color.blue.opacity(0.15)
    private let borderColor = Color.blue
    private var editModeEnabled: Bool {
        editMode?.wrappedValue == .active
    }
    private var borderWidth: CGFloat {
        editModeEnabled ? 2 : 0
    }
    let onCropChanged: ((CGRect) -> Void)

    @Environment(\.editMode) var editMode
    @State private var isDragging = false
    @State private var dragInsets = EdgeInsets()

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(isDragging ? fillColor : Color.clear)
                .border(borderColor, width: borderWidth)
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
        let borderDragableWidth: CGFloat = 50 // > AHIG minimum tapable area (40) 

        var insets = EdgeInsets()
        if abs(startLocation.x) < borderDragableWidth {
            insets.leading += translation.width
        }
        if abs(startLocation.y) < borderDragableWidth {
            insets.top += translation.height
        }
        if abs(width - startLocation.x) < borderDragableWidth {
            insets.trailing -= translation.width
        }
        if abs(height - startLocation.y) < borderDragableWidth {
            insets.bottom -= translation.height
        }
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
            let croppedFrame = originalFrame
                .inset(by: insets.uiEdgeInsets)
                .intersection(originalFrame)
            onCropChanged(croppedFrame)

            isDragging = false
            dragInsets = EdgeInsets() // Reset insets
        }
    }
}

struct CropOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { _ in
            CropOverlayView(onCropChanged: { _ in })
                .environment(\.editMode, Binding.constant(EditMode.active))
                .padding()
                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}

// MARK: -

private extension EdgeInsets {
    var uiEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
    }
}
