//
//  Extension+String.swift
//  BitbucketParsingData
//
//  Created by Alexandra Strugaru on 03.08.21.
//

import Foundation

extension String {

	func dateFromString() -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
		let date = dateFormatter.date(from: self)
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter.string(from: date!)
	}
}
