//
//  SharedServices.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Alamofire
import Foundation

class SharedServices: BaseService {
    func validateResponse(handler: AFDataResponse<BaseResponseModel>, success: @escaping (BaseResponseModel) -> (), failure: @escaping (NSError) -> ()) {
        if let model = handler.value {
            success(model)
            
        } else {
            failure(CommonMethods.getGenericErrorWithError(error: handler.error))
        }
    }
    
    func executePostSplashRequest(success: @escaping (BaseResponseModel) -> (), failure: @escaping (NSError) -> ()) {
        let action = EndPoints.COUNTRY_LISTING
        parameters = ["msisdn": "971502232167", "lang": "en", "buildNumber": "1", "osVersion": "12.0", "osType": "iOS", "deviceId": "37BCD473-EF6C-442C-876D-F1094959E5F", "fcmToken": "fcmToken"] as [String: AnyObject]
        
        executePost(action: action) { (handler: AFDataResponse<BaseResponseModel>) in
            self.validateResponse(handler: handler, success: success, failure: failure)
        }
    }
}
