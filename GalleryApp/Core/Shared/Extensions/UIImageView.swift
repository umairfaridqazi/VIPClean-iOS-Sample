//
//  UIImageView.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func roundImageView() {
        self.layer.cornerRadius = self.frame.size.width * 0.5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.labelPrimaryColor.cgColor
        self.layer.masksToBounds = true
    }

    func downLoadImage(url: String, placeHolderImage: UIImage? = nil, addHeaders: Bool = false, success: ((UIImage) -> ())?, failure: ((NSError) -> ())?) {
        let modifier = AnyModifier { request in
            var r = request
            let headers = Headers.shared.getRequestHeaders()

            if addHeaders {
                for (key, value) in headers {
                    r.setValue(key, forHTTPHeaderField: value)
                }
            }

            return r
        }

        let url = URL(string: url)
        self.kf.setImage(
            with: url,
            placeholder: placeHolderImage,
            options: [.requestModifier(modifier)]) {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                success?(value.image)
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
                let nsError = NSError(domain: error.localizedDescription, code: error.errorCode, userInfo: nil)
                failure?(nsError)
            }
        }
    }
}
