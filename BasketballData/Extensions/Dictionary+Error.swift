//
//  Dictionary+Error.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 6/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
    static func createErrorUserInfoData(message: String, value: String, comment: String) -> [String : Any] {
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey :  NSLocalizedString(message, value: value, comment: comment),
            NSLocalizedFailureReasonErrorKey : NSLocalizedString(message, value: value, comment: comment),
        ]
        
        return userInfo
    }
}
