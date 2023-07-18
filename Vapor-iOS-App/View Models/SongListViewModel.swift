//
//  SongListViewModel.swift
//  Vapor-iOS-App
//
//  Created by Ludovic HENRY on 15/07/2023.
//

import Foundation

class SongListViewModel: ObservableObject {
    @Published var songs: [Song] = []

    func fetchSongs() async throws {
        let urlString = Constant.baseURL + Endpoints.songs
        guard let url = URL(string: urlString) else { throw HttpError.badURL }

        let songsResponse: [Song] = try await HttpClient.shared.fetch(url: url)

        await MainActor.run { songs = songsResponse }
    }

    func deleteSong(at offsets: IndexSet) {
        offsets.forEach { index in
            guard let songID = songs[index].id else { return }
            let urlString: String = Constant.baseURL + Endpoints.songs + "/\(songID)"
            guard let url = URL(string: urlString) else { return }
            Task {
                do {
                    try await HttpClient.shared.delete(at: songID, url: url )
                } catch {
                    print("❌ ERROR: \(error)")
                }
            }
        }
    }
}
