//
//  BaseServicesSecurity.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Alamofire
import UIKit

class BaseServicesSecurity: NSObject {
    /// This method will return the custom Network Security Policy
    ///
    /// - Returns: return ServerTrustPolicyManager object
    class func getCustomNetworkSecurityPolicy() -> ServerTrustManager {
        var certificates: [SecCertificate] = []
        certificates = BaseServicesSecurity.getCertificates()
        
        let trustPolicy = PinnedCertificatesTrustEvaluator(certificates: certificates, acceptSelfSignedCertificates: true, performDefaultValidation: true, validateHost: true)
        let trustPolicies = [Config.serverURL: trustPolicy]
        let policyManager = ServerTrustManager(evaluators: trustPolicies)
        return policyManager
    }
    
    /// This method will return the self signed SSL Certificate
    ///
    /// - Returns: return SecCertificate array
    class func getCertificates() -> [SecCertificate] {
        if let url = Bundle.main.url(forResource: Constants.Network.selfSignedSSLCertificate, withExtension: Constants.Network.selfSignedSSLCertificateType) {
            let localCertificate = try! Data(contentsOf: url) as CFData
            
            guard let certificate = SecCertificateCreateWithData(nil, localCertificate)
            else { return [] }
            
            return [certificate]
        }
        return []
    }
}
