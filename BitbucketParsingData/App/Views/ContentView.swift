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
	@State private var showsAlert = false
	@State private var moreData: [Values] = []

	var body: some View {
		VStack {
			ActivityIndicator(isAnimating: self.$apiManager.isLoading, style: .medium)

			NavigationView {
				ScrollView {
					HStack {
						VStack(alignment: .leading) {
							// Show the display name, type, the date of creation and avatar of the owner
							if let values = self.apiManager.moreData {
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
					// Show Next button on the bottom of the screen when the endpoint for the next page is available in JSON.
					if (self.apiManager.bitbucketValues?.next.isEmpty == false) {
						Button {
							apiManager.fetchData(urlString: self.apiManager.bitbucketValues?.next ?? "")
						} label: {
							Text("Next")
						}
					}
				}
			}
		}
		.padding(.vertical)
		.onAppear {
			apiManager.fetchData(urlString: Constants.url)
		}
	}

	private func parametersDisplay(value: Values) -> some View {
		NavigationLink(destination: DetailView(additionalInformation: AdditionalInformation(website: value.website, forkPolicy: value.fork_policy, language: value.language, size: value.size, description: value.description, name: value.full_name))) {
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
						.foregroundColor(.black)
					Text("Type: \(value.type)")
						.font(.subheadline)
						.foregroundColor(.black)
						.padding(.bottom, 2)
					if let date = value.created_on.dateFromString() {
						Text("Created on: \(date)")
							.font(.subheadline)
							.foregroundColor(.gray)
					}
				}
				Spacer()
				Image(systemName: "chevron.forward")
					.foregroundColor(.gray)
			}
		}
		.navigationTitle("Repository")
		.padding()
		.background(Color(self.colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
		.clipped()
		.cornerRadius(5)
		.shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 1.0)

	}
}

struct ActivityIndicator: UIViewRepresentable {

	@Binding var isAnimating: Bool

	let style: UIActivityIndicatorView.Style

	func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
		return UIActivityIndicatorView(style: style)
	}

	func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
		isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
	}
}
