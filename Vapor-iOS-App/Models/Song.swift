//
//  Song.swift
//  Vapor-iOS-App
//
//  Created by Ludovic HENRY on 15/07/2023.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    let title: String
}
