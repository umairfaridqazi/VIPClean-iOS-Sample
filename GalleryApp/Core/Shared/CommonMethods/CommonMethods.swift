//
//  CommonMethods.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

@objc class CommonMethods: NSObject {
    class func isDevelopmentAppScheme() -> Bool {
        #if Production
        let developmentEnviroment = false
        
        #else
        let developmentEnviroment = true
        
        #endif
        
        return developmentEnviroment
    }
    
    class func getJSONPretty(responseData: Data?) -> String? {
        if let data = responseData {
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                if let prettyPrintedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    return String(bytes: prettyPrintedData, encoding: String.Encoding.utf8) ?? nil
                }
            }
        }
        return nil
    }
    
    class func generateErrorForResponseCode(domain: String = "", responseCode: Int? = Constants.Error.genericErrorCode, responseMessage: String?) -> NSError {
        if let code = responseCode, let message = responseMessage {
            return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: message])
            
        } else {
            return getGenericError()
        }
    }
    
    class func getGenericError() -> NSError {
        return NSError(domain: Constants.Error.genericErrorDomain, code: Constants.Error.genericErrorCode, userInfo: [NSLocalizedDescriptionKey: Constants.Error.genericErrorMessage])
    }
    
    class func getGenericErrorWithError(error: Error?) -> NSError {
        if let nsError = error as NSError? {
            var message = nsError.localizedDescription
            if message.isEmpty {
                message = Constants.Error.genericErrorMessage
            }
            return getErrorWith(domain: nsError.domain, code: nsError.code, message: message)
            
        } else {
            return getGenericError()
        }
    }
    
    
    class func getErrorWith(domain: String, code: Int, message: String) -> NSError {
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: getLocalizedMessageForMessage(message: message)])
    }
    
    class func getLocalizedMessageForMessage(message: String) -> String {
        return Constants.Error.localizedMessages[message] ?? message
    }
    
    public static func getTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        return nil
    }
    
    class func countryName(from countryCode: String) -> String? {
        //        let current = Locale(identifier: "en_US")
        //        return current.localizedString(forRegionCode: countryCode)
        
        let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode)
        return name
    }
    
    class func formattedDateFromString(dateString: String, fromFormat: String, withFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = fromFormat
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = withFormat
            
            return outputFormatter.string(from: date)
        }
        
        return dateString
    }
    
    // MARK: - MSISDN
    
    class func isValidated(byRegex text: String?, withRegEx regex: String?) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex ?? "")
        return predicate.evaluate(with: text)
    }
    
    class func dialNumber(number: String) {
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("Function not available at simulator or invalid url provided")
        }
    }
    
    class func generateQRCodeNew(from string: String, color: UIColor) -> UIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
            let encryptedQrString = string.toBase64()
            let qrData = encryptedQrString.data(using: String.Encoding.ascii)
            qrFilter.setValue(qrData, forKey: "inputMessage")
                   
            let qrTransform = CGAffineTransform(scaleX: 9, y: 9)
            let qrImage = qrFilter.outputImage?.transformed(by: qrTransform)
            if let tintedImage = qrImage?.tinted(using: color){
                return UIImage(ciImage: tintedImage)
            }
            else{
                return nil
            }
    }
    
    class func convertBase64ToImage(imageString: String) -> UIImage? {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)
    }
    
    class func codableToDictionary<T: Codable>(codableObject: T) -> [String: Any] {
        var params: [String: Any] = [:] // = Headers.shared.getRequestHeaders() as [String: AnyObject]
        
        let encoder = JSONEncoder()
        do {
            let data: Data = try encoder.encode(codableObject)
            params = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
        } catch {
            // handle error
        }
        return params
    }
    
    class func textMasking(number: String, mask : String) -> String {
           let cleanPhoneNumber = number.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
           var result = ""
           var index = cleanPhoneNumber.startIndex
           for ch in mask {
               if index == cleanPhoneNumber.endIndex {
                   break
               }
               if ch == "X" || ch == "x" {
                   result.append(cleanPhoneNumber[index])
                   index = cleanPhoneNumber.index(after: index)
               } else {
                   result.append(ch)
               }
           }
           return result
       }
    
}

private extension Bundle {
    var appVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
