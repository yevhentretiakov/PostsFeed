//
//  Int+Ext.swift
//  PostsFeed
//
//  Created by user on 03.07.2022.
//

import Foundation

extension Int {
    
    var toDate: Date {
        return NSDate(timeIntervalSince1970: TimeInterval(self)) as Date
    }
}
