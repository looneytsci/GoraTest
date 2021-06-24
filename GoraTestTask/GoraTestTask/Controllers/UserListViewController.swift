//
//  ViewController.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 22.06.2021.
//

import UIKit

class UserListViewController: UIViewController, ViewControllerProtocol {
    
    // MARK: Properties
    /// Users from JSON
    var responseValue: [User] = []
    var networkManager = NetworkManager()
    var viewModel: ViewModel!
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView!
    
    lazy var activity: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        return ai
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        title = "Users"
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(activity)
        
        activity.startAnimating()
        activity.isHidden = false
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -50)
        ])
        
        viewModel = ViewModel()
        viewModel.setupVC(viewController: self, and: .users) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.activity.stopAnimating()
                self?.activity.isHidden = true
                self?.tableView.reloadData()
            }
        }
    }


}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = responseValue[indexPath.row].name        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        
        // Переход к следующему экрану с альбомами
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "albumListVC") as? AlbumListViewController else { return }
        vc.title = responseValue[indexPath.row].name
        vc.user = responseValue[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
