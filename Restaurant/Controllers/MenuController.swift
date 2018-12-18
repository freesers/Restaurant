//
//  MenuController.swift
//  Restaurant
//
//  Created by Sander de Vries on 11/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    static let shared = MenuController()
    
    let baseURL = URL(string: "https://resto.mprog.nl/")!
    
    /// fetches categories from server, returning in a completion handler
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
    
    /// fetches MenuItems from server, returning in a completion handler
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuUrl = baseURL.appendingPathComponent("menu")
        
        var components = URLComponents(url: initialMenuUrl, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        
        let menuUrl = components.url!
        
        let task = URLSession.shared.dataTask(with: menuUrl) { (data, response, errror) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /// Submits order with POST, returning prep-time in a completion handler
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let menuData: [String: Any] = ["menuIds": menuIds]
        let jsonData = try? JSONSerialization.data(withJSONObject: menuData, options: [])
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /// fetches images from server, returns in completion handler
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
