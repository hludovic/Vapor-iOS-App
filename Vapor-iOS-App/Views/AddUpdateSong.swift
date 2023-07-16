//
//  AddUpdateSong.swift
//  Vapor-iOS-App
//
//  Created by Ludovic HENRY on 15/07/2023.
//

import SwiftUI

struct AddUpdateSong: View {
    @StateObject var viewModel: AddUpdateSongViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("song title", text: $viewModel.songTitle)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                viewModel.addUpdateSong {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }

        }
    }
}

struct AddUpdateSong_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSong(viewModel: AddUpdateSongViewModel())
    }
}
