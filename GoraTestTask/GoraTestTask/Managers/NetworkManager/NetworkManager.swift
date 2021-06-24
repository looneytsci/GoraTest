//
//  NetworkManager.swift
//  GoraTestTask
//
//  Created by Дмитрий Головин on 22.06.2021.
//

import UIKit

/// Cетевой менеджер
///
class NetworkManager {
    
    private var api = "https://jsonplaceholder.typicode.com/"
    private var imageCache = NSCache<NSString, UIImage>()
    
    func fetchDataWith<T: Decodable>(kind: Kind, completion: @escaping ([T]) -> ()) {
        guard let url = URL(string: api + kind.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                if let error = error {
                    print("Failed with error: \(error)")
                }
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode([T].self, from: data)
                completion(decodedData)
            } catch let error {
                print("Decoding failed with error: \(error)")
            }
        }.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> ()) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil,
                      data != nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    return
                }
                
                guard let image = UIImage(data: data!) else { return }
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
    
    /// типы реквестов
    enum Kind: String {
        case users = "users"
        case albums = "albums"
        case photos = "photos"
    }
    
}



