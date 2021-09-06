//
//  File.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//
import XCTest
@testable import JwtApiClient

@available(iOS 15.0.0, *)
class ApiClientTest: XCTestCase {
  func testCreateJsonRequest() async throws {
    let url = URL(string: "https://fake.api.url/users/login")

    let result: URLRequest = try await createJsonRequest(url!)

    let contentTypeHeader = result.value(forHTTPHeaderField: "Content-Type")
    let acceptHeader = result.value(forHTTPHeaderField: "Accept")

    XCTAssertEqual(result.url, url)
    XCTAssertEqual(contentTypeHeader, "application/json")
    XCTAssertEqual(acceptHeader, "application/json")
  }

  func testCreateJsonBodyRequest() async throws {
    let url = URL(string: "https://fake.api.url/users/login")
    let credentials = [
      "login": "joe@bloggs.com",
      "password": "topSecret"
    ]
    let expectedEncodedCredentials = "{\"login\":\"joe@bloggs.com\",\"password\":\"topSecret\"}"

    let result: URLRequest = try await createJsonBodyRequest(url, credentials)
    let httpBody = String(decoding: result.httpBody!, as: UTF8.self)

    XCTAssertEqual(result.httpMethod, "POST")
    XCTAssertEqual(httpBody, expectedEncodedCredentials)
  }

//  func testPostJsonDictionary() async throws {
//    let url = URL(string: "https://fake.api.url/users/login")
//    let credentials = [
//      "email": "joe@bloggs.com",
//      "password": "topS3cret"
//    ]
//
//    let result: <<YourTypeHere>> = try await postJsonDictionary(url!, credentials)
//
////    print("Received token: \(result.token)")
//    XCTAssertTrue(result.token.count > 0)
//  }

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

  //  func testGetWithAuthorisation() async throws {
  //    let jwtToken = "your.token.here"
  //    let endpoint = "your://endpoint.url"
  //
  //    let result: <<YourTypeHere>> = try await getWithAuthorisation(endpoint, token: jwtToken)
  //
  //    // your assertions here
  //  }
}
