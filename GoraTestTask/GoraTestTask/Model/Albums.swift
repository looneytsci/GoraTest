//
//  Albums.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 23.06.2021.
//

import Foundation

/// Моделька для альбомов
///
struct Album: Decodable {
    var id: Int
    var userId: Int
    var title: String
}
