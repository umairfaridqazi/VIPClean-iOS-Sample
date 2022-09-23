//
//  Headers.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum DeviceHeaderField {
    static let deviceId = "device_id"
}

enum ContentType: String {
    case json = "application/json"
    case bearer = "Bearer "
}

class Headers: NSObject {
    // MARK: - Variables
    
    private var requestHeaders: [String: String]
    
    static var shared = {
        Headers()
    }()
    
    // MARK: - Inilizers
    
    override init() {
        requestHeaders = Dictionary()
        super.init()
        addDeviceHeaders()
    }
    
    // MARK: - Helper Methods
    
    func getRequestHeaders() -> [String: String] {
        updateDeviceHeaders()
        return requestHeaders
    }
    
    /// This method will call to update all required headers
    func updateDeviceHeaders() {
        Device.sharedManager.updateDeviceHeaders()
        addDeviceHeaders()
    }
    
    private func addDeviceHeaders() {
        for (key, values) in Device.sharedManager.deviceHeaders {
            addHeader(key: key, header: values)
        }
    }
    
    private func addHeader(key: String, header: String) {
        requestHeaders[key] = header
    }
}
