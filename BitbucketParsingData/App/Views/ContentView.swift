//
//  ContentView.swift
//  BitbucketParsingData
//
//  Created by Alexandra Strugaru on 03.08.21.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ContentView: View {

	@ObservedObject var apiManager: APIManager = APIManager()
	@Environment(\.colorScheme) var colorScheme
	@State var showsAlert = false
	@State var shouldHide = false

	var body: some View {
		VStack {
			NavigationView {
				ScrollView {
					HStack {
						VStack(alignment: .leading) {
							// Show the display name, type, the date of creation and avatar of the owner
							if let values = self.apiManager.bitbucketValues?.values {
								ForEach(values, id: \.full_name) { value in
									self.parametersDisplay(value: value)
								}
							} else {
								if let error = self.apiManager.error {
									Button(action: {
										self.showsAlert.toggle()
									}) {
										Text("Show Alert")
									}
									.alert(isPresented: self.$showsAlert) {
										Alert(title: Text("\(error.messageForError)"))
									}
								}
							}
						}
						.padding()
					}
				}
			}

			// Show Next button on the bottom of the screen when the endpoint for the next page is available in JSON.
			if (self.apiManager.bitbucketValues?.next.isEmpty == false) {
				Button {} label: {
					Text("Next")
				}
			}
		}
		.padding(.vertical)
		.onAppear {
			apiManager.fetchData()
		}
	}

	private func parametersDisplay(value: Values) -> some View {
		HStack {
			KFImage(URL(string: value.owner.links.avatar.href))
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 80, height: 80)
				.clipped()
			VStack(alignment: .leading) {
				Text("Full name: \(value.full_name)")
					.bold()
					.padding(.bottom, 2)
				Text("Type: \(value.type)")
					.font(.subheadline)
					.padding(.bottom, 2)
				if let date = value.created_on.dateFromString() {
					Text("Created on: \(date)")
						.font(.subheadline)
						.foregroundColor(.gray)
				}
			}
			Spacer()
		}
		.padding()
		.background(Color(self.colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
		.clipped()
		.cornerRadius(5)
		.shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 1.0)

	}
	
}
