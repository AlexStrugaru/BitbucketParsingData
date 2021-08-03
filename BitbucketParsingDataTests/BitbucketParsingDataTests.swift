//
//  BitbucketParsingDataTests.swift
//  BitbucketParsingDataTests
//
//  Created by Alexandra Strugaru on 03.08.21.
//

import XCTest
@testable import BitbucketParsingData

let jsonString = """
{
	"pagelen": 10,
	"next": "https://api.bitbucket.org/2.0/repositories?after=2011-09-03T12%3A33%3A16.028393%2B00%3A00",
	"values": [{
		"website": "",
		"has_wiki": true,
		"has_issues": true,
		"uuid": "sadsd",
		"type": "repository",
		"created_on": "2013-04-12T22:42:52.654728+00:00",
		"fork_policy": "allow_fork",
		"full_name": "Test",
		"updated_on": "2013-06-12T22:42:52.654728+00:00",
		"size": 2345,
		"type": "repository",
		"slug": "streams-jira-delete-issue-plugin",
		"is_private": false,
		"language": "Swift",
		"description": "",
		"owner": {
			"display_name": "Test",
			"uuid": "a2363",
			"links": {
				"avatar": {
					"href": "https://secure.gravatar.com/avatar/f6bcbb4e3f665e74455bd8c0b4b3afba?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FEZ-4.png"
				}
			}
		}
	}]
}
"""

class BitbucketParsingDataTests: XCTestCase {

	var value: Values?
	var owner: Owner?
	var links: Links?
	var avatar: Avatar?
	var repository: Repository?

	override func setUp() {

		self.avatar = Avatar(href: "https://secure.gravatar.com/avatar/f6bcbb4e3f665e74455bd8c0b4b3afba?d=https%3A%2F%2Favatar-management--avatars.us-west-2.prod.public.atl-paas.net%2Finitials%2FEZ-4.png")

		guard let avatar = self.avatar else {
			return
		}

		self.links = Links(avatar: avatar)

		guard let links = self.links else {
			return
		}

		self.owner = Owner(display_name: "Test", uuid: "a2363", links: links)

		guard let owner = self.owner else {
			return
		}

		self.value = Values(website: "", has_wiki: true, uuid: "sadsd", has_issues: true, language: "Swift", created_on: "2013-04-12T22:42:52.654728+00:00", fork_policy: "allow_forks", full_name: "Test", updated_on: "2013-06-12T22:42:52.654728+00:00", size: 2345, type: "repository", slug: "streams-jira-delete-issue-plugin", is_private: false, description: "", owner: owner)

		guard let value = self.value else {
			return
		}

		self.repository = Repository(pagelen: 10, next: "s", values: [value])
	}

	func testJSONNextStringDecodedSuccefully() {
		let decoder = JSONDecoder()
		let data = jsonString.data(using: .utf8)!
		let decoded = try! decoder.decode(Repository.self, from: data)
		XCTAssertEqual(decoded.next, self.repository?.next)
	}

	func testJSONImageStringDecodedSuccefully() {
		let decoder = JSONDecoder()
		let data = jsonString.data(using: .utf8)!
		let decoded = try! decoder.decode(Repository.self, from: data)
		XCTAssertEqual(decoded.values[0].owner.links.avatar.href, self.repository?.values[0].owner.links.avatar.href)
	}
}
