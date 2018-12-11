//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Sander de Vries on 11/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
