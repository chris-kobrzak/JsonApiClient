//
//  File.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//
import XCTest
@testable import JwtApiClient

class ApiClientTest: XCTestCase {
  @available(iOS 15.0.0, *)
  func testCreateAuthorisedRequest() async throws {
    let url = URL(string: "https://fake.api.url")
    let jwtToken = "foo.bar.baz"

    let result: URLRequest = try await createAuthorisedRequest(url!, token: jwtToken)

    let authHeader = result.value(forHTTPHeaderField: "Authorization")
    let acceptHeader = result.value(forHTTPHeaderField: "Accept")

    XCTAssertEqual(result.url, url)
    XCTAssertEqual(authHeader, "Bearer \(jwtToken)")
    XCTAssertEqual(acceptHeader, "application/json")
  }

//  @available(iOS 15.0.0, *)
//  func testRequestWithAuthorisation() async throws {
//    let jwtToken = "your.token.here"
//    let endpoint = "your://endpoint.url"
//
//    let result: <<YourTypeHere>> = try await requestWithAuthorisation(endpoint, token: jwtToken)
//
//    // your assertions here
//  }
}
