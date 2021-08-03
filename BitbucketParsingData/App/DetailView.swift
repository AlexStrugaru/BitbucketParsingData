//
//  DetailView.swift
//  BitbucketParsingData
//
//  Created by Alexandra Strugaru on 04.08.21.
//

import SwiftUI

struct AdditionalInformation {
	let website: String
	let has_wiki: Bool
	let forkPolicy: String
	let language: String
	let size: Int
	let isPrivate: Bool
	let description: String
	let hasIssues: Bool
	let name: String
}

struct DetailView: View {

	let additionalInformation: AdditionalInformation

	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		DetailView()
	}
}
