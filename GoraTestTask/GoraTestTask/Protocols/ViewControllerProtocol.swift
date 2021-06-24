//
//  ViewControllerProtocol.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 24.06.2021.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    associatedtype Response where Response: Decodable
    var responseValue: [Response] { get set }
    var networkManager: NetworkManager { get set }
    var viewModel: ViewModel! { get set }
}
