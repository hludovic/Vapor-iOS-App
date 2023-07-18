//
//  AddUpdateSongViewModel.swift
//  Vapor-iOS-App
//
//  Created by Ludovic HENRY on 15/07/2023.
//

import Foundation

final class AddUpdateSongViewModel: ObservableObject {
    @Published var songTitle: String =  ""

    var songID: UUID?

    var isUpdating: Bool {
        songID != nil
    }

    var buttonTitle: String {
        songID != nil ? "Update Song" : "Add Song"
    }

    init() { }
    init(currentSong: Song) {
        songTitle = currentSong.title
        songID = currentSong.id
    }

    func addSong() async throws {
        let stringURL = Constant.baseURL + Endpoints.songs
        guard let url = URL(string: stringURL) else { throw HttpError.badURL }
        let song = Song(id: nil, title: songTitle)
        try await HttpClient.shared.sendData(to: url, data: song, httpMethod: HttpMethods.POST.rawValue)
    }

    func updateSong() async throws {
        let stringURL = Constant.baseURL + Endpoints.songs
        guard let url = URL(string: stringURL) else { throw HttpError.badURL }
        let songToUpdate = Song(id: songID, title: songTitle)
        try await HttpClient.shared.sendData(to: url, data: songToUpdate, httpMethod: HttpMethods.PUT.rawValue)
    }

    func addUpdateSong(completion: @escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                    try await updateSong()
                } else {
                    try await addSong()
                }
            } catch {
                print("❌ ERROR: \(error)")
            }
            completion()
        }
    }
}
