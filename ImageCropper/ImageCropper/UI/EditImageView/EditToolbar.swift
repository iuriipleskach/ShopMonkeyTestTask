//
//  EditToolbar.swift
//  ImageCropper
//
//  Created by Yuriy Pleskach on 27.03.2021.
//

import SwiftUI

struct EditToolbar: View {
    let cancel: () -> Void
    let save: () -> Void
    let undo: () -> Void

    @Environment(\.editMode) var editMode

    var body: some View {
        if editMode?.wrappedValue == .active {
            HStack {
                Button("Cancel", action: exitEditModeAndCancel)
                Spacer()
                Button("Undo", action: undo)
                Button("Save", action: exitEditModeAndSave)
            }
            .padding()
        } else {
            HStack {
                Spacer()
                EditButton()
            }
            .padding()
        }
    }

    // MARK: -

    private func exitEditModeAndSave() {
        editMode?.wrappedValue = .inactive
        save()
    }

    private func exitEditModeAndCancel() {
        editMode?.wrappedValue = .inactive
        cancel()
    }
}


struct EditToolbar_Previews: PreviewProvider {
    static var previews: some View {
        EditToolbar(cancel: {}, save: {}, undo: {})
        EditToolbar(cancel: {}, save: {}, undo: {})
            .environment(\.editMode, Binding.constant(EditMode.active))
    }
}
