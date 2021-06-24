//
//  AlbumListViewController.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 23.06.2021.
//

import UIKit

class AlbumListViewController: UITableViewController, ViewControllerProtocol {
    

    // MARK: Properties
    var networkManager = NetworkManager()
    var user: User!
    var responseValue: [Album] = []
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        viewModel.setupVC(viewController: self, and: .albums) { [weak self] in
            self?.responseValue = (self?.responseValue.filter { $0.userId == self?.user.id })!
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseValue.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell",for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = responseValue[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        
        guard let photoVC = storyboard?.instantiateViewController(withIdentifier: "photoListVC") as? PhotoListViewController else { return }
        photoVC.title = title
        photoVC.album = responseValue[indexPath.row]
        navigationController?.pushViewController(photoVC, animated: true)
    }
    
}
