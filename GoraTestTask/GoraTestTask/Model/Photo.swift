//
//  Photo.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 23.06.2021.
//

import Foundation

/// Моделька для фото
///
struct Photo: Decodable {
    var title: String
    var url: String
    var albumId: Int
}
