//
//  UserListViewModel.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 24.06.2021.
//

import UIKit

class ViewModel {
    
    func setupVC<VC: ViewControllerProtocol>(viewController: VC, and download: NetworkManager.Kind, completion: @escaping () -> ()) {        
        DispatchQueue.global(qos: .utility).async { [weak viewController] in
            viewController?.networkManager.fetchDataWith(kind: download, completion: { [weak viewController] (response: [VC.Response]) in
                viewController?.responseValue = response
                completion()
            })
        }
    }
}
