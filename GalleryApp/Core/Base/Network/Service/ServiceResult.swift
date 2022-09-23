//
//  ServiceResult.swift
//  VIPCleanWorkingTemplate
//
//  Created by Umair Farid on 10/02/2021.
//  Copyright © 2021 Systems. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
    case success(T)
    case failure(Error)
}
