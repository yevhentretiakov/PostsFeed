//
//  Date+Ext.swift
//  PostsFeed
//
//  Created by user on 03.07.2022.
//

import Foundation

extension Date {
    
    func extract(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
