//
//  File.swift
//  File
//
//  Created by Chris Kobrzak on 03/09/2021.
//
import XCTest
@testable import JwtApiClient

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
    let credentials: [String : Any] = [
      "login": "joe@bloggs.com",
      "password": 12345
    ]
    let expectedEncodedCredentials = "{\"login\":\"joe@bloggs.com\",\"password\":12345}"

    let result: URLRequest = try await createJsonBodyRequest(url, credentials)
    let httpBody = String(decoding: result.httpBody!, as: UTF8.self)
    let contentTypeHeader = result.value(forHTTPHeaderField: "Content-Type")
    let acceptHeader = result.value(forHTTPHeaderField: "Accept")

    XCTAssertEqual(result.url, url)
    XCTAssertEqual(contentTypeHeader, "application/json")
    XCTAssertEqual(acceptHeader, "application/json")
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

  func testCreateAuthorisedJsonBodyRequest() async throws {
    let url = URL(string: "https://fake.api.url/users")!
    let jwtToken = "baz.bar.foo"
    let data: [String : Any] = [
      "foo": "bar",
      "baz": 123
    ]
    let expectedEncodedCredentials = "{\"baz\":123,\"foo\":\"bar\"}"

    let result: URLRequest = try await createAuthorisedJsonBodyRequest(url, token: jwtToken, dictionary: data)
    let httpBody = String(decoding: result.httpBody!, as: UTF8.self)
    let authHeader = result.value(forHTTPHeaderField: "Authorization")
    let acceptHeader = result.value(forHTTPHeaderField: "Accept")
    let contentTypeHeader = result.value(forHTTPHeaderField: "Content-Type")

    XCTAssertEqual(result.url, url)
    XCTAssertEqual(authHeader, "Bearer \(jwtToken)")
    XCTAssertEqual(acceptHeader, "application/json")
    XCTAssertEqual(contentTypeHeader, "application/json")
    XCTAssertEqual(httpBody, expectedEncodedCredentials)
  }

  //  func testPostJsonDictionaryWithToken() async throws {
  //    let jwtToken = "your.token.here"
  //    let endpoint = "your://endpoint.url"
  //    let data: [String : Any] = [
  //      "foo": "bar",
  //      "baz": 123
  //    ]
  //
  //    let result: <<YourTypeHere>> = try await postJsonDictionaryWithToken(endpoint, token: jwtToken, dictionary: data)
  //
  //    // your assertions here
  //  }

  /*
  func testPatchJsonDictionaryWithToken() async throws {
    let jwtToken = "foo.bar.baz"
    let endpoint = URL(string: "https://fake.api.url/books/123")!

    let data: [String : Any] = [
      "bar": "baz"
    ]

    try await patchJsonDictionaryWithToken(endpoint, token: jwtToken, dictionary: data)

    // your assertions here
  }
  */

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

  //  func testGetWithToken() async throws {
  //    let jwtToken = "your.token.here"
  //    let endpoint = "your://endpoint.url"
  //
  //    let result: <<YourTypeHere>> = try await getJsonWithToken(endpoint, token: jwtToken)
  //
  //    // your assertions here
  //  }
}
