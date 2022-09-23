//
//  UIApplication.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    static func openAppSettings(completion: @escaping (_ isSuccess: Bool) -> ()) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            completion(false)
            return
        }

        let app = UIApplication.shared

        app.open(url) { isSuccess in
            completion(isSuccess)
        }
    }

    static func openPhoneSettings(completion: @escaping (_ isSuccess: Bool) -> ()) {
        guard let url = URL(string: "App-Prefs:root=General") else {
            completion(false)
            return
        }

        let app = UIApplication.shared

        app.open(url) { isSuccess in
            completion(isSuccess)
        }
    }
}
