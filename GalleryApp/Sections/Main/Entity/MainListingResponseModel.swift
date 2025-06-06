//
//  MainListingResponseModel.swift
//  GalleryApp
//
//  Created by Umair Farid on 31/08/2021.
//  
//

import Foundation

struct MainListingResponseModel: Codable {
    // MARK: - Model Keys
    
    enum CodingKeys: String, CodingKey {
        case value1
        case value2
    }
    
    // MARK: - Model Variables
    
    var value1: String?
    var value2: String?
    
    // MARK: - Model mapping
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value1 = try values.decodeIfPresent(String.self, forKey: .value1)
        value2 = try values.decodeIfPresent(String.self, forKey: .value2)
    }
}
