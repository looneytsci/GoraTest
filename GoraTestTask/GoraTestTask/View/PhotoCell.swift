//
//  PhotoCell.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 23.06.2021.
//

import UIKit

/// Подкласс ячеек на экране с фото
///
class PhotoCell: UITableViewCell {
    // imageView для фото в ячейке
    @IBOutlet weak var photo: UIImageView! {
        didSet {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    // title для фото
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // Слои для визуальной модификации ячейки
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var shadowView: UIView!
}
