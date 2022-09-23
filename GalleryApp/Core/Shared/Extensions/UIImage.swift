//
//  UIImage.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension UIImage {
    
    var jpeg: Data? { jpegData(compressionQuality: 0.4) } // QUALITY min = 0 / max = 1
    var png: Data? { pngData() }

    func blurImage() -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(cgImage: self.cgImage!)

        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(30.0, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage

        var cgImage: CGImage?

        if let image = outputImage {
            cgImage = context.createCGImage(image, from: inputImage.extent)
        }
        if let cgImageA = cgImage {
            return UIImage(cgImage: cgImageA)
        }

        return nil
    }
}
