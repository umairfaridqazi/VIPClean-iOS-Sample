//
//  NumberFormatterExtensions.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import UIKit

extension NumberFormatter {
    func amountNumberFormatter() {
        let groupingSeparator = ","
        self.positiveFormat = "###,###"
        self.groupingSeparator = groupingSeparator
    }
    
    func amountCheckText(field: String) -> String {
        let returnField = field.replacingOccurrences(of: ",", with: "")
        return returnField
    }
}
