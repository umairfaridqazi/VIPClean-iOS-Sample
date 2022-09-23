//
//  DataRequest.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Alamofire
import Foundation

struct ResponseStatusModel: Codable {
    var responseCode: String = "1"
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseCode = try (values.decodeIfPresent(String.self, forKey: .responseCode) ?? "1")
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}

extension DataRequest {
    public func validateRequest() -> Self {
        return validate { request, _, data in
            
            if !Reachability.isReachable {
                print("===============================================")
                print("Network Error")
                print("===============================================")
                
                return .failure(CommonMethods.getGenericError())
            }
            
//            self.validate()
            
            guard let data = data else {
                print("===============================================")
                print("Data is invalid for request \(request?.url?.absoluteString ?? "")")
                print("===============================================")
                return .failure(CommonMethods.getGenericError())
            }
            
            do {
                let responseObject = try JSONDecoder().decode(ResponseStatusModel.self, from: data)
                
                let code = responseObject.responseCode
                let newCode = responseObject.responseCode
                
                if Parser.isRequestSuccess(responseCode: code) || Parser.isRequestSuccess(responseCode: newCode) {
                    return .success(())
                } else {
                    let message = responseObject.responseMessage
                    let domain = responseObject.responseCode
                    let code = Int(domain) ?? 0
                    return .failure(CommonMethods.generateErrorForResponseCode(domain: domain, responseCode: code, responseMessage: message))
                }
                
            } catch {
                print("===============================================")
                print(error.localizedDescription)
                print("For request \(request?.url?.absoluteString ?? "")")
                print("===============================================")
                return .failure(CommonMethods.getGenericError())
            }
        }
    }
}
