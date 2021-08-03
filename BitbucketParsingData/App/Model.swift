//
//  Model.swift
//  BitbucketParsingData
//
//  Created by Alexandra Strugaru on 03.08.21.
//

import Foundation

struct Repository: Decodable {
	let pagelen: Int
	let next: String
	let values: [Values]
}
struct Values: Decodable {
	let website: String
	let has_wiki: Bool
	let uuid: String
	let has_issues: Bool
	let language: String
	let created_on: String
	let fork_policy: String
	let full_name: String
	let updated_on: String
	let size: Int
	let type: String
	let slug: String
	let is_private: Bool
	let description: String
	let owner: Owner
}

struct Owner: Decodable {
	let display_name: String
	let uuid: String
	let links: Links
}

struct Links: Decodable {
	let avatar: Avatar
}

struct Avatar: Decodable {
	let href: String
}

struct Project: Decodable {
	let type: String
	let name: String
	let key: String
	let uuid: String
}

struct MainBranch: Decodable {
	let type: String
	let name: String
}

struct Workspace: Decodable {
	let slug: String
	let type: String
	let name: String
	let uuid: String
}
