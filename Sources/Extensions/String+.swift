//
//  String+.swift
//  GPXMergerCLI
//
//  Created by Kevin Boulala on 10/06/2025.
//

import Foundation

extension String {
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: self)
    }
}
