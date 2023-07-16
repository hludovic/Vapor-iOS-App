//
//  ModalType.swift
//  Vapor-iOS-App
//
//  Created by Ludovic HENRY on 15/07/2023.
//

import Foundation

enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    case add
    case update(Song)
}
