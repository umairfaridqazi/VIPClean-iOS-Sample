//
//  Parser.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Alamofire
import Foundation

@objc class Parser: NSObject {
    /// This method is responsible for Parsing the Response of request in which single object is return in request
    ///
    /// - Parameters:
    ///   - response: incomming response object of generic DataResponse type
    ///   - completionHandler: completionHandler for call back
    class func parseResponse<T: Codable>(response: AFDataResponse<T>, request: DataRequest, showRetryIfNeeded: Bool = true, completionHandler: @escaping (AFDataResponse<T>) -> ()) {
        // Log request        
        let isDebuging = Config.logEnabled
        if let b = isDebuging.bool {
            if b {
                _logRequest(response: response)
            }
        }
        
        // Check if retry needed
        let isSessionExpird = checkForSessionExpiry(response: response)
        if isSessionExpird {
            throwTimeOutError(errorDescription: response.error?.localizedDescription ?? "Your session ended. Please login again")
            
        } else if showRetryIfNeeded || !Reachability.isReachable {
           // CommonMethods.showRetryViewControllerForRequest(request: request, response: response)
            
        } else {
            let headers = response.response?.allHeaderFields
            if let headers = headers, headers.keys.contains("Etisalat-AuthToken") {
                _ = headers["Etisalat-AuthToken"] as! String
//                AccountManager.shared.sessionToken = authToken
            }
        }
        
        completionHandler(response)
    }
    
    /// This method is responsible for Handling the session expiry in application. As webservices standard, session exipry is only supped in 410 Http Header Response Code.
    ///
    /// - Parameter response: is the object of DataResponse type
    class func checkForSessionExpiry<T: Codable>(response: AFDataResponse<T>) -> Bool {
        let error = response.error as NSError?
        if response.response?.statusCode == Constants.Network.sessionExpiredCode ||
            (error?.domain ?? "" == "\(Constants.Network.sessionExpiredCode)" || error?.domain ?? "" == Constants.Network.sessionExpiredCodeString1) {
            return true
        }
        return false
    }
    
    class func throwTimeOutError(errorDescription: String) {
       
    }
    
    /// This method will check if the Request is Success for Business logic
    ///
    /// - Parameter baseModel: input Response Model
    /// - Returns: return flag for success Request
//    class func isRequestSuccess(baseModel: BaseResponseModel?) -> Bool {
//        if let statusCode = baseModel?.responseCode {
//            return isRequestSuccess(responseCode: statusCode)
//        }
//        return false
//    }
    
    class func isRequestSuccess(responseCode: String) -> Bool {
           
        if Constants.Network.successResponseCode == responseCode || Constants.Network.successResponseCode1 == responseCode || Constants.Network.successResponseCode2 == responseCode || Constants.Network.successResponseCode3 == responseCode ||
            Constants.Network.googleSuccessCode == responseCode
            {
            return true
        } else {
            return false
        }
    }
    
    private class func _logRequest<T: Codable>(response: AFDataResponse<T>) {
        var dataJSON = response.data?.prettyJSONString() ?? ""
        
        print("\n✅✅✅✅✅========================== REQUEST START ==========================✅✅✅✅✅\n")
        
        if let url = response.request?.url?.absoluteString {
            print("URL: \n\(url)\n")
        }
        
        if let method = response.request?.httpMethod {
            print("METHOD: \n\(method)\n")
        }
        
        if let headers = response.request?.allHTTPHeaderFields {
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: headers,
                options: []) {
                print("HEADERS: \n\(theJSONData.prettyJSONString()!)")
            }
        }
        
        if let body = CommonMethods.getJSONPretty(responseData: response.request?.httpBody) {
            print("REQUEST: \n\(body)\n")
        }
        
        if dataJSON.isEmpty {
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                dataJSON = responseString
            }
        }
        print("RESPONSE: \n\(dataJSON)\n")
        
        print("✅✅✅✅✅========================== REQUEST END ==========================✅✅✅✅✅")
        print("\n")
    }
}
