//
//  BaseResponseModel.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation

class BaseResponseModel: Codable {
    var responseCode: String?
    var responseMessage: String?
    var status: String?
    var error: String?
    
    init() {}
    
    private enum CodingKeys: String, CodingKey {
        case responseCode
        case responseMessage = "message"
        case status
        case error
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}
