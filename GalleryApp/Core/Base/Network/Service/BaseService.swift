//
//  BaseService.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Alamofire
import Foundation

@objc public class BaseService: NSObject {
    // MARK: - Variables
    
    var parameters: [String: AnyObject]
    var headers: HTTPHeaders
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = TimeInterval(Constants.Network.timeoutIntervalForRequest)
        configuration.timeoutIntervalForResource = TimeInterval(Constants.Network.timeoutIntervalForResource)
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadRevalidatingCacheData
        configuration.httpCookieStorage = nil
        
        var trustedPolicy: ServerTrustManager?
        
        if CommonMethods.isDevelopmentAppScheme(), BaseServiceUtils.baseUrlImplementedSSL() {
            trustedPolicy = BaseServicesSecurity.getCustomNetworkSecurityPolicy()
        }
        
        let sessionManager = Session(configuration: configuration)
        
        return sessionManager
    }()
    
    // MARK: - Initilizers
    
    override init() {
        parameters = Dictionary()
        headers = HTTPHeaders()
    }
    
    func executeRequest<T: Codable>(request: DataRequest, completionHandler: @escaping (AFDataResponse<T>) -> ()) {
        request.validateRequest().responseDecodable(of: T.self) { response in
            Parser.parseResponse(response: response, request: request, completionHandler: completionHandler)
        }
    }
    
    // MARK: - GET MEHTOD
    
    /// This is the generic webservice method of type 'GET' for web service calling
    ///
    /// - Parameters:
    ///   - action: service end point
    ///   - completionHandler: generic call back completion handler
    func executeGet<T: Codable>(action: String, ignorBaseUrl: Bool = false, showRetryIfNeeded: Bool = false, completionHandler: @escaping (AFDataResponse<T>) -> ()) {
//        parameters.merge(Headers.shared.getRequestHeaders() as [String: AnyObject]) { $1 }
        
        let urlString = getRequestURL(action: action, parameters: parameters, ignorBaseUrl: ignorBaseUrl)
        let request = sessionManager.request(urlString, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding(options: []), headers: headers)
        
        request.validateRequest().responseDecodable(of: T.self) { response in
            Parser.parseResponse(response: response, request: request, completionHandler: completionHandler)
        }
    }
    
    // MARK: - POST MEHTOD
    
    /// This is the generic webservice method of type 'POST' for web service calling
    ///
    /// - Parameters:
    ///   - action: service end point
    ///   - completionHandler: generic call back completion handler
    func executePost<T: Codable>(action: String, ignorBaseUrl: Bool = false, ignorCustomHeader: Bool = false, showRetryIfNeeded: Bool = false, completionHandler: @escaping (AFDataResponse<T>) -> ()) {
        var params = Headers.shared.getRequestHeaders() as [String: AnyObject]
        
        params.merge(parameters) { $1 }
        
        let urlString = getRequestURL(action: action, ignorBaseUrl: ignorBaseUrl)
        let request = sessionManager.request(urlString, method: HTTPMethod.post, parameters: ignorCustomHeader ? parameters : params, encoding: JSONEncoding(options: []), headers: headers)
        request.validateRequest().responseDecodable(of: T.self) { response in
            Parser.parseResponse(response: response, request: request, completionHandler: completionHandler)
        }
    }
    
    // MARK: - PUT MEHTOD
    
    func executePut<T: Codable>(action: String, ignorBaseUrl: Bool = false, showRetryIfNeeded: Bool = false, completionHandler: @escaping (AFDataResponse<T>) -> ()) {
        parameters.merge(Headers.shared.getRequestHeaders() as [String: AnyObject]) { $1 }
        
        let urlString = getRequestURL(action: action, ignorBaseUrl: ignorBaseUrl)
        let request = sessionManager.request(urlString, method: HTTPMethod.put, parameters: parameters, encoding: JSONEncoding(options: []), headers: headers)
        request.validateRequest().responseDecodable(of: T.self) { response in
            Parser.parseResponse(response: response, request: request, completionHandler: completionHandler)
        }
    }
    
    // MARK: - DELETE MEHTOD
    
    func executeDelete<T: Codable>(action: String, ignorBaseUrl: Bool = false, showRetryIfNeeded: Bool = false, completionHandler: @escaping (AFDataResponse<T>) -> ()) {
        parameters.merge(Headers.shared.getRequestHeaders() as [String: AnyObject]) { $1 }
        let urlString = getRequestURL(action: action, ignorBaseUrl: ignorBaseUrl)
        let request = sessionManager.request(urlString, method: HTTPMethod.delete, parameters: parameters, encoding: JSONEncoding(options: []), headers: headers)
        request.validateRequest().responseDecodable(of: T.self) { response in
            Parser.parseResponse(response: response, request: request, completionHandler: completionHandler)
        }
    }
    
    func executeMultipartForm<T: Codable>(action: String, ignorBaseUrl: Bool = false, showRetryIfNeeded: Bool = false, multipartFormData: @escaping ((MultipartFormData) -> ()),
                                          uploadProgress: @escaping ((Progress) -> ()),
                                          sessionTask: ((_ task: URLSessionTask) -> ())?, completionHandler: @escaping (AFDataResponse<T>) -> (), failiure: @escaping (_ error: NSError) -> ()) {
//        parameters.merge(Headers.shared.getRequestHeaders() as [String: AnyObject]) { $1 }
        
//        var params = Headers.shared.getRequestHeaders() as [String: AnyObject]
//        params.merge(parameters) { $1 }
        
        let urlString = getRequestURL(action: action, ignorBaseUrl: ignorBaseUrl)
        
        let request = sessionManager.upload(multipartFormData: multipartFormData, to: urlString, method: .post, headers: headers, interceptor: nil, fileManager: .default, requestModifier: nil)
        request.validateRequest().responseDecodable(of: T.self) { response in
            Parser.parseResponse(response: response, request: request, completionHandler: completionHandler)
        }
    }
    
    func getParameterFromRequest(data: Data?) -> [String: AnyObject]? {
        // make sure we got data
        guard let responseData = data else {
            print("Error: did not receive data")
            return nil
        }
        // parse the result as JSON, since that's what the API provides
        do {
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                print("error trying to convert data to JSON")
                return nil
            }
            return json as [String: AnyObject]
        }
        catch {
            print("error trying to convert data to JSON")
            return nil
        }
    }
    
    func clearParameter() {
        parameters = Dictionary()
    }
    
    /// This method will return the complete Request URL String
    ///
    /// - Parameters:
    ///   - action: end point of request
    ///   - parameters: Dictionory of parameters
    ///   - ignorBaseUrl: Bool flag to ignore Base URL
    /// - Returns: return URL String
    private func getRequestURL(action: String, parameters: [String: AnyObject]? = nil, ignorBaseUrl: Bool = false) -> String {
        var getAction = action
        
        if let params = parameters {
            if !params.keys.isEmpty {
                getAction = getAction + "?"
            }
            for (index, parm) in params.enumerated() {
                getAction = getAction + parm.key + "=" + (parm.value as! String)
                if index < params.count - 1 {
                    getAction = getAction + "&"
                }
            }
        }
        var urlString = ""
        
        if !ignorBaseUrl {
            urlString = Config.serverURL
        }
        
        return URLString(string: urlString + getAction)
    }
    
    func URLString(string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
}
