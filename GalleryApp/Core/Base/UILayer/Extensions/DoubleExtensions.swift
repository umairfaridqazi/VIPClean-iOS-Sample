//
//  DoubleExtension.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation

extension Double {

    func splitIntoParts(decimalPlaces: Int, initValue: Double) -> (leftPart: String, rightPart: String) {
        
        let formatter = NumberFormatter()

        var number = self

        formatter.amountNumberFormatter()
//        let text = formatter.string(from: NSNumber(value: initValue))
        
        let divisor = pow(10.0, Double(decimalPlaces))
        number = Darwin.round(self * divisor) / divisor

        //convert to string and split on decimal point:
        let parts = String(number).components(separatedBy: ".")

        //extract left and right parts:
        let intPart = Int(parts[0])
        let ns = NSNumber(value: intPart ?? 0)
        let leftPart = formatter.string(from: ns)
        var rightPart = ""
        
        if(parts[1].count == 1) {
            rightPart = parts[1] + "0"
        } else {
            rightPart = parts[1]
        }
        
        var returnLeft = ""
        if (leftPart != nil) {
            returnLeft = leftPart!
        }
        
        return(returnLeft, rightPart)
    }
}
