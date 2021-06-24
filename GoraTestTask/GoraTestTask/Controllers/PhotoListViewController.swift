//
//  PhotoListViewController.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 23.06.2021.
//

import UIKit

class PhotoListViewController: UIViewController, ViewControllerProtocol {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var networkManager = NetworkManager()
    var responseValue: [Photo] = []
    var album: Album!
    var cellViewModel: PhotoCellViewModel!
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellViewModel = PhotoCellViewModel()
        viewModel = ViewModel()
        viewModel.setupVC(viewController: self, and: .photos) { [weak self] in
            if let response = self?.responseValue {
                self?.responseValue = response.filter { $0.albumId == self?.album.id }
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return responseValue.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // отступ между ячейками (секциями)
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoCell        
        cellViewModel.configureCell(cell, at: indexPath, with: responseValue)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
}
