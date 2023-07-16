//
//  HttpClient.swift
//  Vapor-iOS-App
//
//  Created by Ludovic HENRY on 15/07/2023.
//

import Foundation

enum HttpError: Error {
    case badURL, badResponse, errorEncodingData, invalidURL
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
}

enum HttpMethods: String {
    case POST, GET, PUT, DELETE

}

class HttpClient {
    private init() { }

    static let shared = HttpClient()

    func fetch<T: Codable> (url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw HttpError.badResponse }
        guard let object = try? JSONDecoder().decode([T].self, from: data) else {
            throw HttpError.errorEncodingData
        }
        return object
    }

    func sendData<T: Codable> (to url: URL, data: T, httpMethod: String) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        guard let jsonData = try? JSONEncoder().encode(data) else {
            return print("Non encodable error")
        }
        request.httpBody = jsonData
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw HttpError.badResponse }
    }
}
