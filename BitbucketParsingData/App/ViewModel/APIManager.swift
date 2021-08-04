//
//  APIManager.swift
//  BitbucketParsingData
//
//  Created by Alexandra Strugaru on 03.08.21.
//

import Foundation

enum Constants {
	static let url = "https://api.bitbucket.org/2.0/repositories"
}

enum ResponseError {
	case invalidUrl
	case errorStatusCode
	case invalidResponse
	case invalidData
	case invalidJson

	var messageForError: String {
		switch self {
		case .errorStatusCode:	return "Status code different than 200"
		case .invalidJson: 		return "Unable to parse Json"
		case .invalidData: 		return "Unable to parse data"
		case .invalidResponse: 	return "Error in response"
		case .invalidUrl: 		return "Invalid url"
		}
	}
}

class APIManager: ObservableObject {

	@Published var bitbucketValues: Repository?
	@Published var moreData: [Values]? = []
	@Published var error: ResponseError?
	@Published var isLoading: Bool = true

	func fetchData(urlString: String) {

		guard let url = URL(string: urlString) else {
			self.error = .invalidUrl
			return
		}

		let urlRequest = URLRequest(url: url)

		let _ = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in

			guard let urlResponse = urlResponse as? HTTPURLResponse else {
				self.error = .invalidResponse
					return
			}

			guard (urlResponse.statusCode == 200) else {
				self.error = .invalidUrl
				return
			}

			guard let data = data else {
				self.error = .invalidData
				return
			}

			do {
				let values = try JSONDecoder().decode(Repository.self, from: data)
				DispatchQueue.main.async {
					self.isLoading = false
					self.bitbucketValues = values
					self.moreData?.append(contentsOf: self.bitbucketValues?.values ?? [])
				}
			} catch {
				DispatchQueue.main.async {
					self.error = .invalidJson
				}
			}
		}.resume()
	}
}
