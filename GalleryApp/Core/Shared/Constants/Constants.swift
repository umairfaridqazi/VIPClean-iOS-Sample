//
//  Constants.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension String {
    static let NotificationName = "NotificationName"
}

extension Notification.Name {
    static let NotificationName = Notification.Name(.NotificationName)
}

class Constants: NSObject {
    struct Error {
        static let genericErrorDomain = ""
        static let genericErrorCode = 111111
        static let genericErrorMessage = "Something went wrong"

        static let networkErrorDomain = ""
        static let networkErrorCode = -1009
        static let networkErrorMessage = "Network is not working. Please try again."
        static let networkErrorTitle = "Network not found"
        static let networkErrorSubTitle = "Please try again"

        static let localizedMessages = [
            "A server with the specified hostname could not be found.": networkErrorMessage,
            "The request timed out.": networkErrorMessage,
            "Connection request timed out": networkErrorMessage,
            "The Internet connection appears to be offline.": networkErrorMessage
        ]
    }

    // Registeration OTP Constants
    struct RegistrationOTP {
        static let USERNAME_REGEX = "^[a-zA-Z. ]{0,40}$"
        static let PHONE_NUM_REGEX = "^(5)[0-9]{8,8}$"
        static let EMIRATE_ID_REGEX = "^[0-9-]{18}$"
        static let NAME_REGEX = "[a-zA-Z][a-zA-Z ]+"

        /// Titles
        static let WELCOME = "Welcome"
    }

    struct ApplicationConstants {
        // Application Keys
        static let helplineNumber: String = "8003925538"
    }

    struct Network {
        static let messageResponseKey = "message"
        static let statusCodeKey = "responseCode"
        static let newStatusCodekey = "status"
        static let sessionExpiredCode = 401
        static let errorsArray = "errors"
        static let sessionExpiredCodeString = "EWP-403"
        static let sessionExpiredCodeString1 = "440"
        static let successResponseCode = "1"
        static let successResponseCode1 = "0"
        static let successResponseCode2 = ""
        static let successResponseCode3 = "40401"
        static let googleSuccessCode = "OK"

        static let timeoutIntervalForRequest = 120
        static let timeoutIntervalForResource = 120

        static let selfSignedSSLCertificate = "DegitalAppCRT"
        static let selfSignedSSLCertificateType = "crt"
        static let httpSSLConstant = "https"
        static let newStatusCodeKey = "status"
    }

    struct AlertStrings {
        static let alertTypeTitleOkButton = "okBtnTitle"
        static let alertTypeAppName = "Jazz Cash"
        static let alertTypeServerIssue = "server_error_Message"
        static let alertTypeInternetIssue = "internetErrorMsg"
    }
}

//let kMainRedColour = "#780000"


//let APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
//let BUNDLE_VERSION = Bundle.main.infoDictionary?["CFBundleVersion"] as! String // 版本号(内部标示)

//let DEVICE_UUID = UIDevice.current.identifierForVendor?.uuidString
//let isPhoneDevice = (UI_USER_INTERFACE_IDIOM() == .phone)
//let photoRootPath = NSHomeDirectory().appending("/Documents/")

var isPhoneX: Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom != 0
}

let IPHONEX_OFFSET_Y: CGFloat = isPhoneX ? 24 : 0
let IPHONEX_OFFSET_BOTTOM: CGFloat = isPhoneX ? 34 : 0
