//
//  LocationService.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

@objc public class LocationService: BaseService {
    
    func getAddressFromLocation(location: CLLocation, completionHandler: @escaping (ServiceResult<String>) -> ()) {
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if let error = error{
                completionHandler(.failure(error))
            } else {
                
                let place = placemark! as [CLPlacemark]
                if place.count > 0 {
                    let place = placemark![0]
                    var addressString : String = ""
                    if place.thoroughfare != nil {
                        addressString = addressString + place.thoroughfare! + ", "
                    }
                    if place.subThoroughfare != nil {
                        addressString = addressString + place.subThoroughfare! + "\n"
                    }
                    if place.locality != nil {
                        addressString = addressString + place.locality! + " - "
                    }
                    if place.postalCode != nil {
                        addressString = addressString + place.postalCode! + "\n"
                    }
                    if place.subAdministrativeArea != nil {
                        addressString = addressString + place.subAdministrativeArea! + " - "
                    }
                    if place.country != nil {
                        addressString = addressString + place.country!
                    }
                    
                    if addressString.count > 0 {
                        completionHandler(.success(addressString))
                    }else{
                        completionHandler(.failure(CommonMethods.getGenericError()))
                    }
                }else{
                    completionHandler(.failure(CommonMethods.getGenericError()))
                }
            }
        }
    }
    
    func getLocationFromAddress(address: String, completionHandler: @escaping (ServiceResult<CLLocation>) -> ()) {
        
        let key : String = "AIzaSyDq-m4upIK3X_6md49Om_e2lIUNa_y5bmw"
        let getarameters:[String: Any] = [ "address": address,"key":key]
        let url : String = "https://maps.googleapis.com/maps/api/geocode/json"
        
        AF.request(url, method: .get, parameters: getarameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON {  response in
                
                switch response.result {
                case .success(let JSON):
                    
                    let responseJson = JSON as! NSDictionary
                    
                    guard let results = responseJson["results"] as? [[String: Any]],
                        let status = responseJson["status"] as? String,
                        status == "OK" else {
                            completionHandler(.failure(CommonMethods.getGenericError()))
                            return
                    }
                    
                    guard let geometry = results.first?["geometry"] as? [String: Any],let location = geometry["location"] as? [String: Any] , let lat:Double = location["lat"] as? Double, let lng:Double = location["lng"] as? Double else {
                        completionHandler(.failure(CommonMethods.getGenericError()))
                        return
                    }
                    
                    let cllocation = CLLocation(latitude: lat, longitude: lng)
                    completionHandler(.success(cllocation))

                    
                case .failure(let error):
                    completionHandler(.failure(error))
                }
        }
    }
}
