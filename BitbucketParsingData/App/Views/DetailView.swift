//
//  DetailView.swift
//  BitbucketParsingData
//
//  Created by Alexandra Strugaru on 04.08.21.
//

import SwiftUI

struct AdditionalInformation {
	let website: String
	let forkPolicy: String
	let language: String
	let size: Int
	let description: String
	let name: String
}

struct DetailView: View {

	let additionalInformation: AdditionalInformation

	var body: some View {
		VStack(alignment: .leading) {
				Text("Name: ")
					.bold()
				+ Text(additionalInformation.name)
				Text("Description: ")
					.bold()
				+ Text(additionalInformation.description)
				Text("Fork Policy: ")
					.bold()
				+ Text(additionalInformation.forkPolicy)
				Text("Language: ")
					.bold()
				+ Text(additionalInformation.language)
			if let url = URL(string: additionalInformation.website) {
				HStack {
					Text("Website: ")
					Link(additionalInformation.website, destination: url)
				}
			}

		}
		Spacer()
		.padding()
	}
}

struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		DetailView(additionalInformation: AdditionalInformation(website: "", forkPolicy: "fork_allowed", language: "Swift", size: 2345, description: "", name: "Test"))
	}
}
