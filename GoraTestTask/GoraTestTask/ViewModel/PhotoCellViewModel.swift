//
//  PhotoListViewModel.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 23.06.2021.
//

import UIKit

class PhotoCellViewModel {
    
    private let networkManager = NetworkManager()
    
    func configureCell(_ cell: PhotoCell, at indexPath: IndexPath, with photos: [Photo]) {        
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        // настройка ячейки
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        // Скругление
        cell.backView.layer.cornerRadius = 10
        cell.backView.layer.masksToBounds = true
        cell.backView.layer.borderColor = UIColor.black.cgColor
        cell.clipsToBounds = true
        cell.backView.backgroundColor = .clear
        
        // Тени
        cell.shadowView.layer.masksToBounds = false
        cell.shadowView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        cell.shadowView.layer.shadowColor = UIColor.black.cgColor
        cell.shadowView.layer.shadowOpacity = 0.5
        cell.shadowView.layer.shadowRadius = 4
        cell.shadowView.backgroundColor = .clear
        
        // загрузка title для фото
        cell.photoDescription.text = photos[indexPath.section].title
        
        // загрузка картинки
        guard let url = URL(string: photos[indexPath.section].url) else { return }
        networkManager.downloadImage(url: url) { image in
            cell.photo.image = image
            cell.activityIndicator.stopAnimating()
            cell.activityIndicator.isHidden = true
        }
        
    }
    
}
